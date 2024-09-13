import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_cubit.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_state.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:flutter_clean_architecture_spotify/features/music/discovery/discovery.dart';
import 'package:flutter_clean_architecture_spotify/features/music/favorite/favorite.dart';
import 'package:flutter_clean_architecture_spotify/features/music/home/home.dart';
import 'package:flutter_clean_architecture_spotify/features/music/profile/profile.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomApp extends StatefulWidget {
  const BottomApp({super.key});

  @override
  State<BottomApp> createState() => _BottomAppState();
}

class _BottomAppState extends State<BottomApp> {
  late PersistentTabController controller;
  int selectedIndex = 0;
  late NowPlayingCubit cubit;

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
    cubit = sl<NowPlayingCubit>();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      floatingActionButton: _buildFAB(),
      screens: _buildScreens(),
      items: _navBarsItems(),
      onItemSelected: (value) => setState(() {
        selectedIndex = value;
      }),
    );
  }

  Widget _buildFAB() {
    return BlocSelector<NowPlayingCubit, NowPlayingState, SongEntity>(
      selector: (state) {
        return state.song;
      },
      builder: (context, song) {
        if (song.content == '') return Container();
        return GestureDetector(
          onTap: () {
            GoRouter.of(context)
                .pushNamed(AppRoutes.nowPlaying, extra: {'song': song, 
                  'uniqueTag': 'hana'
                });
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            transform: Matrix4.translationValues(10, 0, 0),
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: AppColors.lightBackground))),
            child: Row(
              children: [
                // image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: 'hana${song.cover}',
                    child: Image.network(
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      song.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // title
                    Text(
                      song.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    // artist
                    Text(
                      song.artist,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ],
                ),
                // actions
                const Spacer(),
                BlocSelector<NowPlayingCubit, NowPlayingState, bool>(
                  selector: (state) {
                    return state.isPlaying;
                  },
                  builder: (context, isPlaying) {
                    return IconButton(
                        onPressed: cubit.handlePlayPause,
                        icon: SvgPicture.asset(
                          isPlaying ? AppVectors.icPlaying : AppVectors.btnPlay,
                          colorFilter: const ColorFilter.mode(
                              AppColors.darkBackground, BlendMode.srcIn),
                        ));
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: cubit.handleClose,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        );
      },
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
