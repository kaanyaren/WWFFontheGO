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
      final response = await dio.get('https://wwff.co/wwff-data/wwff_directory.csv');
      
      if (response.statusCode != 200) {
        throw Exception('Failed to download CSV: ${response.statusCode}');
      }

      final csvContent = response.data.toString();
      print('Parsing CSV into records...');
      
      // Split into lines and find header
      final lines = csvContent.split('\n');
      final headerIndex = lines.indexWhere((l) => l.startsWith('reference,status'));
      
      if (headerIndex == -1) {
        throw Exception('CSV header not found');
      }

      final dataLines = lines.skip(headerIndex).join('\n');
      
      // Use compute to parse in background if needed, but for simplicity here we parse directly
      // as Isar write is the main bottleneck.
      final converter = const CsvToListConverter();
      final rows = converter.convert(dataLines, shouldParseNumbers: false);
      
      if (rows.isEmpty) return;
      
      final headers = rows.first.map((e) => e.toString()).toList();
      final refIdx = headers.indexOf('reference');
      final nameIdx = headers.indexOf('name');
      final stateIdx = headers.indexOf('state');
      final latIdx = headers.indexOf('latitude');
      final lonIdx = headers.indexOf('longitude');
      final statusIdx = headers.indexOf('status');

      final parks = <Park>[];
      for (var i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.length <= statusIdx) continue;
        
        final status = row[statusIdx].toString().toLowerCase();
        if (status != 'active') continue;

        final park = Park()
          ..reference = row[refIdx].toString()
          ..name = row[nameIdx].toString()
          ..state = row[stateIdx].toString();
        
        final latStr = row[latIdx].toString();
        final lonStr = row[lonIdx].toString();
        
        if (latStr.isNotEmpty && lonStr.isNotEmpty) {
          park.latitude = double.tryParse(latStr);
          park.longitude = double.tryParse(lonStr);
        }
        
        parks.add(park);
      }

      print('Saving ${parks.length} active parks to local database...');
      
      // Write in batches of 5000 to keep UI responsive
      for (var i = 0; i < parks.length; i += 5000) {
        final batch = parks.sublist(i, (i + 5000) > parks.length ? parks.length : i + 5000);
        await isar.writeTxn(() async {
          await isar.parks.putAll(batch);
        });
        print('Saved ${i + batch.length}/${parks.length} parks...');
      }

      print('Local database sync complete.');
    } catch (e) {
      print('CSV Sync Error: $e');
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
