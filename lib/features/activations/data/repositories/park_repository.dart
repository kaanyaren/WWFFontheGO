import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar_community/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<void> syncParksFromFirestore() async {
    try {
      final snapshot = await _firestore.collection('parks').get();
      final parks = snapshot.docs.map((doc) {
        final data = doc.data();
        return Park()
          ..reference = data['reference'] ?? ''
          ..name = data['name'] ?? ''
          ..state = data['state'] ?? ''
          ..imageUrl = data['imageUrl']
          ..latitude = (data['latitude'] as num?)?.toDouble()
          ..longitude = (data['longitude'] as num?)?.toDouble();
      }).toList();


      await isar.writeTxn(() async {
        await isar.parks.putAll(parks);
      });
    } catch (e) {
      // Firebase not configured or other error
      print('Park Sync Error: $e');
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
