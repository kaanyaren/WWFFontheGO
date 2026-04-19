import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final parkSyncServiceProvider = Provider((ref) => ParkSyncService());

class ParkSyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Dio _dio = Dio();

  static const String csvUrl = 'https://wwff.co/wwff-data/wwff_directory.csv';

  Future<void> importParksFromCsv() async {
    try {
      final response = await _dio.get(csvUrl);
      if (response.statusCode != 200) throw Exception('Failed to download CSV');

      final String csvData = response.data;
      // The CSV has a few preamble lines in the file I saw? 
      // Line 1: Source: ...
      // Line 2: (empty)
      // Line 3: ---
      // Line 4: (empty)
      // Line 5: reference,status,...
      
      // Let's clean the data first. 
      final lines = csvData.split('\n');
      final startIndex = lines.indexWhere((l) => l.startsWith('reference,status'));
      if (startIndex == -1) throw Exception('Invalid CSV format: Header not found');
      
      final cleanedCsvData = lines.sublist(startIndex).join('\n');
      final List<List<dynamic>> rows = CsvToListConverter().convert(cleanedCsvData);


      if (rows.length < 2) return;

      final header = rows[0].map((e) => e.toString().trim()).toList();
      final refIdx = header.indexOf('reference');
      final nameIdx = header.indexOf('name');
      final stateIdx = header.indexOf('state');
      final latIdx = header.indexOf('latitude');
      final lonIdx = header.indexOf('longitude');
      final statusIdx = header.indexOf('status');

      final batchSize = 500;
      WriteBatch batch = _firestore.batch();
      int count = 0;

      for (int i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.length <= refIdx || row.length <= statusIdx) continue;

        final status = row[statusIdx].toString();
        if (status != 'active') continue;

        final reference = row[refIdx].toString();
        final name = row[nameIdx].toString();
        final state = row[stateIdx].toString();
        final latitude = double.tryParse(row[latIdx].toString());
        final longitude = double.tryParse(row[lonIdx].toString());

        final docRef = _firestore.collection('parks').doc(reference);
        batch.set(docRef, {
          'reference': reference,
          'name': name,
          'state': state,
          'latitude': latitude,
          'longitude': longitude,
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        count++;
        if (count % batchSize == 0) {
          await batch.commit();
          batch = _firestore.batch();
        }
      }

      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
