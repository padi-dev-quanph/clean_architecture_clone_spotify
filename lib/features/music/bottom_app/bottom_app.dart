import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/features/music/discovery/discovery.dart';
import 'package:flutter_clean_architecture_spotify/features/music/favorite/favorite.dart';
import 'package:flutter_clean_architecture_spotify/features/music/home/home.dart';
import 'package:flutter_clean_architecture_spotify/features/music/profile/profile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomApp extends StatefulWidget {
  const BottomApp({super.key});

  @override
  State<BottomApp> createState() => _BottomAppState();
}

class _BottomAppState extends State<BottomApp> {
  late PersistentTabController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PersistentTabView(
          context,
          controller: controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          onItemSelected: (value) => setState(() {
            selectedIndex = value;
          }),
        ),
        // current playing music
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildFAB(),
        )
      ],
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () {},
      child: Container(
        child: Text('playing'),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const DiscoveryPage(),
      const FavoritePage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppVectors.icHomeBottomAppBar,
          colorFilter: ColorFilter.mode(
              selectedIndex == 0 ? AppColors.primary : AppColors.grey,
              BlendMode.srcIn),
        ),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppVectors.icDiscoveryBottomAppBar,
          colorFilter: ColorFilter.mode(
              selectedIndex == 1 ? AppColors.primary : AppColors.grey,
              BlendMode.srcIn),
        ),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppVectors.icFavoriteBottomAppBar,
          colorFilter: ColorFilter.mode(
              selectedIndex == 2 ? AppColors.primary : AppColors.grey,
              BlendMode.srcIn),
        ),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppVectors.icProfileBottomAppBar,
          colorFilter: ColorFilter.mode(
              selectedIndex == 3 ? AppColors.primary : AppColors.grey,
              BlendMode.srcIn),
        ),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
    ];
  }
}
