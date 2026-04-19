import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../activations/presentation/pages/park_list_page.dart';
import '../../../logging/presentation/pages/log_list_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../spots/presentation/pages/spots_page.dart';

class MainDashboard extends ConsumerStatefulWidget {
  const MainDashboard({super.key});

  @override
  ConsumerState<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends ConsumerState<MainDashboard> {
  /// Controller to handle PageView and also NotchBottomBar.
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle auto animaiton of notch bottom bar.
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// List of pages
    final List<Widget> bottomBarPages = [
      const LogListPage(),
      const SpotsPage(),
      const ParkListPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        /// Provide NotchBottomBarController
        notchBottomBarController: _controller,
        color: Colors.white.withOpacity(0.9),
        showLabel: true,
        textOverflow: TextOverflow.visible,
        // maxCount: 4, // Removed as it's not defined in this version
        notchColor: Theme.of(context).primaryColor,
        kBottomRadius: 28.0, // Required parameter
        kIconSize: 24.0, // Required parameter

        /// restart scan on change of the tab
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        },
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.list_alt_outlined, color: Colors.blueGrey),
            activeItem: Icon(Icons.list_alt, color: Colors.white),
            itemLabel: 'Logs',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.radar_outlined, color: Colors.blueGrey),
            activeItem: Icon(Icons.radar, color: Colors.white),
            itemLabel: 'Spots',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.forest_outlined, color: Colors.blueGrey),
            activeItem: Icon(Icons.forest, color: Colors.white),
            itemLabel: 'Parks',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.settings_outlined, color: Colors.blueGrey),
            activeItem: Icon(Icons.settings, color: Colors.white),
            itemLabel: 'Settings',
          ),
        ],
      ),
    );
  }
}
