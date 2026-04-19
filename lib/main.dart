import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/gradient_background.dart';
import 'core/utils/database_service.dart';
import 'core/router/app_router.dart';
import 'features/settings/data/repositories/settings_repository.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize Local Database (Isar)
  final dbService = DatabaseService();
  await dbService.init();

  runApp(
    ProviderScope(
      overrides: [
        databaseServiceProvider.overrideWithValue(dbService),
      ],
      child: const WwffApp(),
    ),
  );
}

class WwffApp extends ConsumerWidget {
  const WwffApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final profileAsync = ref.watch(userProfileProvider);

    final isDark = profileAsync.whenOrNull(
          data: (profile) => profile?.isDarkTheme ?? false,
        ) ??
        false;

    return MaterialApp.router(
      title: 'WWFF on the GO',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) {
        return GradientBackground(
          forceBrightness: isDark ? Brightness.dark : Brightness.light,
          child: child!,
        );
      },
    );
  }
}
