import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../activations/presentation/pages/park_list_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../spots/presentation/pages/spots_page.dart';

class MainDashboard extends ConsumerStatefulWidget {
  const MainDashboard({super.key});

  @override
  ConsumerState<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends ConsumerState<MainDashboard> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const ParkListPage(),
      const SpotsPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: bottomBarPages,
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white.withOpacity(0.9),
        showLabel: true,
        textOverflow: TextOverflow.visible,
        notchColor: Theme.of(context).primaryColor,
        kBottomRadius: 28.0,
        kIconSize: 24.0,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        },
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.forest_outlined, color: Colors.blueGrey),
            activeItem: Icon(Icons.forest, color: Colors.white),
            itemLabel: 'Parks',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.radar_outlined, color: Colors.blueGrey),
            activeItem: Icon(Icons.radar, color: Colors.white),
            itemLabel: 'Spots',
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
