import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_profile.dart';
import '../../../../core/utils/database_service.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return SettingsRepository(dbService.isar);
});

final userProfileProvider = StreamProvider<UserProfile?>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.watchUserProfile();
});

class SettingsRepository {
  final Isar isar;

  SettingsRepository(this.isar);

  Future<UserProfile?> getUserProfile() async {
    return isar.userProfiles.get(1);
  }

  Stream<UserProfile?> watchUserProfile() {
    return isar.userProfiles.watchObject(1, fireImmediately: true);
  }

  Future<void> updateProfile(UserProfile profile) async {
    await isar.writeTxn(() async {
      await isar.userProfiles.put(profile);
    });
  }
}
