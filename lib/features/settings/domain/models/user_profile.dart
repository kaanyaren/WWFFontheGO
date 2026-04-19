import 'package:isar_community/isar.dart';

part 'user_profile.g.dart';

@collection
class UserProfile {
  Id id = 1; // Singleton Pattern, we only need one profile per device

  String? defaultCallsign;
  String? defaultOperator;
  String? defaultMySigInfo; // Current park being activated
  int? defaultTxPower;
  
  // Settings
  bool isDarkTheme = false;
}
