import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar_community/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:csv/csv.dart';
import '../../domain/models/park.dart';
import '../../../../core/utils/database_service.dart';

final parkRepositoryProvider = Provider<ParkRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return ParkRepository(dbService.isar);
});

final parkListProvider = StreamProvider<List<Park>>((ref) {
  final repository = ref.watch(parkRepositoryProvider);
  return repository.watchAllParks();
});

class ParkRepository {
  final Isar isar;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ParkRepository(this.isar);

  bool _isSyncing = false;

  Future<void> syncParksFromCSV() async {
    if (_isSyncing) {
      print('Sync already in progress. Skipping...');
      return;
    }

    _isSyncing = true;
    try {
      print('Downloading WWFF Directory CSV...');
      final dio = Dio();
      // WWFF CSV might be large, use a reasonable timeout
      dio.options.connectTimeout = const Duration(seconds: 30);
      dio.options.receiveTimeout = const Duration(minutes: 5);
      
      final response = await dio.get('https://wwff.co/wwff-data/wwff_directory.csv');
      
      if (response.statusCode != 200) {
        throw Exception('Failed to download CSV: ${response.statusCode}');
      }

      String csvContent = response.data.toString();
      
      print('CSV length: ${csvContent.length} chars');
      
      // Robust header finding
      int headerStart = csvContent.indexOf('reference,status');
      if (headerStart == -1) {
        throw Exception('CSV header not found');
      }
      
      final dataLines = csvContent.substring(headerStart);
      
      print('Parsing CSV into records...');
      // Csv class in version 8.0.0
      final rows = csv.decode(dataLines);
      
      if (rows.isEmpty) {
        print('CSV parsed into 0 rows');
        return;
      }
      
      print('Found ${rows.length} rows including header');
      
      final headers = rows.first.map((e) => e.toString()).toList();
      final refIdx = headers.indexOf('reference');
      final nameIdx = headers.indexOf('name');
      final stateIdx = headers.indexOf('state');
      final latIdx = headers.indexOf('latitude');
      final lonIdx = headers.indexOf('longitude');
      final statusIdx = headers.indexOf('status');
      
      print('Indexes: ref=$refIdx, status=$statusIdx, name=$nameIdx, state=$stateIdx, lat=$latIdx, lon=$lonIdx');

      if (refIdx == -1 || statusIdx == -1 || latIdx == -1) {
        throw Exception('Required columns missing in CSV');
      }

      final parks = <Park>[];
      int activeCount = 0;
      int skippedCount = 0;

      for (var i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.length <= statusIdx || row.length <= latIdx || row.length <= lonIdx) {
          skippedCount++;
          continue;
        }
        
        final status = row[statusIdx].toString().trim().toLowerCase();
        if (status != 'active') {
          continue;
        }
        
        activeCount++;

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
        
        // Final validation: Reference and Lat/Lon must be present for map
        if (park.reference.isNotEmpty && park.latitude != null && park.longitude != null) {
           parks.add(park);
        } else {
           skippedCount++;
        }
      }

      print('Total parsed: ${rows.length}, Active: $activeCount, Valid for Map: ${parks.length}, Skipped: $skippedCount');
      
      if (parks.isEmpty) {
        print('No valid parks found to save.');
        return;
      }

      print('Clearing old parks and saving ${parks.length} new parks...');
      
      await isar.writeTxn(() async {
        // We clear existing parks to ensure we have the latest directory
        // and to fix any previous half-syncs
        await isar.parks.clear();
        
        // Write in batches of 5000 to keep UI responsive
        for (var i = 0; i < parks.length; i += 5000) {
          final end = (i + 5000) > parks.length ? parks.length : i + 5000;
          final batch = parks.sublist(i, end);
          await isar.parks.putAll(batch);
          print('Saved ${end}/${parks.length} parks...');
        }
      });

      print('Local database sync complete.');
    } catch (e, stack) {
      print('CSV Sync Error: $e');
      print(stack);
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
