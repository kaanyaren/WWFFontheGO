import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/logging/domain/models/qso_log.dart';
import '../../features/settings/domain/models/user_profile.dart';
import '../../features/activations/domain/models/park.dart';

// We initialize this in main.dart and pass it to ProviderScope
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  throw UnimplementedError('DatabaseService must be initialized before being used.');
});

class DatabaseService {
  late final Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [QsoLogSchema, UserProfileSchema, ParkSchema],
      directory: dir.path,
    );
    
    // Seed initial UserProfile if it doesn't exist
    final profileCount = await isar.userProfiles.count();
    if (profileCount == 0) {
      await isar.writeTxn(() async {
        await isar.userProfiles.put(UserProfile());
      });
    }
  }
}
