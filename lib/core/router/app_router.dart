import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/pages/main_dashboard.dart';
import '../../features/home/presentation/pages/splash_page.dart';
import '../../features/logging/presentation/pages/log_entry_page.dart';
import '../../features/spots/domain/models/spot.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const MainDashboard(),
      ),
      GoRoute(
        path: '/log/new',
        builder: (context, state) {
          final spot = state.extra as WwffSpot?;
          return LogEntryPage(preFillSpot: spot);
        },
      ),
    ],
  );
});
