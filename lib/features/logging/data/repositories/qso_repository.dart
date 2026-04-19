import 'package:isar_community/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/qso_log.dart';
import '../../../../core/utils/database_service.dart';

final qsoRepositoryProvider = Provider<QsoRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return QsoRepository(dbService.isar);
});

final qsoListProvider = StreamProvider<List<QsoLog>>((ref) {
  final repository = ref.watch(qsoRepositoryProvider);
  return repository.watchAllLogs();
});

class QsoRepository {
  final Isar isar;

  QsoRepository(this.isar);

  Future<List<QsoLog>> getAllLogs() async {
    return isar.qsoLogs.where().sortByQsoDateDesc().thenByTimeOnDesc().findAll();
  }

  Stream<List<QsoLog>> watchAllLogs() {
    return isar.qsoLogs
        .where()
        .sortByQsoDateDesc()
        .thenByTimeOnDesc()
        .watch(fireImmediately: true);
  }

  Future<void> addLog(QsoLog log) async {
    await isar.writeTxn(() async {
      await isar.qsoLogs.put(log);
    });
  }

  Future<void> deleteLog(Id id) async {
    await isar.writeTxn(() async {
      await isar.qsoLogs.delete(id);
    });
  }

  Future<void> clearLogs() async {
    await isar.writeTxn(() async {
      await isar.qsoLogs.clear();
    });
  }
}
