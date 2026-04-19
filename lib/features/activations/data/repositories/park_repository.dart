import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:csv/csv.dart';
import '../../domain/models/park.dart';
import '../../../../core/utils/database_service.dart';
import '../../../../core/network/dio_provider.dart';

final parkRepositoryProvider = Provider<ParkRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  final dio = ref.watch(dioProvider);
  return ParkRepository(dbService.isar, dio);
});

final parkListProvider = StreamProvider<List<Park>>((ref) {
  final repository = ref.watch(parkRepositoryProvider);
  return repository.watchAllParks();
});

// Top-level function for compute
List<Park> _parseCsvInBackground(String csvContent) {
  int headerStart = csvContent.indexOf('reference,status');
  if (headerStart == -1) throw Exception('CSV header not found');
  
  final dataLines = csvContent.substring(headerStart);
  final rows = Csv().decode(dataLines);
  
  if (rows.isEmpty) return [];
  
  final headers = rows.first.map((e) => e.toString()).toList();
  final refIdx = headers.indexOf('reference');
  final nameIdx = headers.indexOf('name');
  final stateIdx = headers.indexOf('state');
  final latIdx = headers.indexOf('latitude');
  final lonIdx = headers.indexOf('longitude');
  final statusIdx = headers.indexOf('status');

  if (refIdx == -1 || statusIdx == -1 || latIdx == -1) {
    throw Exception('Required columns missing in CSV');
  }

  final parks = <Park>[];
  for (var i = 1; i < rows.length; i++) {
    final row = rows[i];
    if (row.length <= statusIdx || row.length <= latIdx || row.length <= lonIdx) continue;
    
    final status = row[statusIdx].toString().trim().toLowerCase();
    if (status != 'active') continue;
    
    final park = Park()
      ..reference = row[refIdx].toString().trim()
      ..name = row[nameIdx].toString().trim()
      ..state = row[stateIdx].toString().trim();
    
    final latVal = row[latIdx];
    final lonVal = row[lonIdx];
    
    if (latVal != null && lonVal != null) {
      park.latitude = double.tryParse(latVal.toString());
      park.longitude = double.tryParse(lonVal.toString());
    }
    
    if (park.reference.isNotEmpty && park.latitude != null && park.longitude != null) {
       parks.add(park);
    }
  }
  return parks;
}

class ParkRepository {
  final Isar isar;
  final Dio dio;

  ParkRepository(this.isar, this.dio);

  bool _isSyncing = false;

  Future<void> syncParksFromCSV() async {
    if (_isSyncing) {
      debugPrint('Sync already in progress. Skipping...');
      return;
    }

    _isSyncing = true;
    try {
      debugPrint('Downloading WWFF Directory CSV...');
      final response = await dio.get('https://wwff.co/wwff-data/wwff_directory.csv');
      
      if (response.statusCode != 200) {
        throw Exception('Failed to download CSV: ${response.statusCode}');
      }

      String csvContent = response.data.toString();
      debugPrint('Parsing CSV into records...');
      
      final parks = await compute(_parseCsvInBackground, csvContent);
      
      if (parks.isEmpty) {
        debugPrint('No valid parks found to save.');
        return;
      }

      debugPrint('Clearing old parks and saving ${parks.length} new parks...');
      
      await isar.writeTxn(() async {
        await isar.parks.clear();
        for (var i = 0; i < parks.length; i += 5000) {
          final end = (i + 5000) > parks.length ? parks.length : i + 5000;
          final batch = parks.sublist(i, end);
          await isar.parks.putAll(batch);
        }
      });

      debugPrint('Local database sync complete.');
    } catch (e) {
      debugPrint('CSV Sync Error: $e');
      rethrow;
    } finally {
      _isSyncing = false;
    }
  }

  Stream<List<Park>> watchAllParks() {
    return isar.parks.where().sortByReference().watch(fireImmediately: true);
  }

  Future<List<Park>> searchParks(String query) async {
    if (query.isEmpty) return isar.parks.where().sortByReference().findAll();
    return isar.parks
        .filter()
        .referenceContains(query, caseSensitive: false)
        .or()
        .nameContains(query, caseSensitive: false)
        .findAll();
  }
}
