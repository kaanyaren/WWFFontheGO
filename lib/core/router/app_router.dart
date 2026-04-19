import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/pages/main_dashboard.dart';
import '../../features/logging/presentation/pages/log_list_page.dart';
import '../../features/logging/presentation/pages/log_entry_page.dart';
import '../../features/spots/presentation/pages/spots_page.dart';
import '../../features/activations/presentation/pages/park_list_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainDashboard(),
      ),
      GoRoute(
        path: '/log/new',
        builder: (context, state) => const LogEntryPage(),
      ),
    ],
  );
});
