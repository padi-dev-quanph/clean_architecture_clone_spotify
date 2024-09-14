import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_cubit.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_state.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';
import 'package:flutter_svg/svg.dart';

class SongAction extends StatelessWidget {
  const SongAction({super.key});

  @override
  Widget build(BuildContext context) {
        return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
                height: 24, width: 24, fit: BoxFit.cover, AppVectors.icRepeat),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
                height: 26,
                width: 26,
                fit: BoxFit.cover,
                AppVectors.icPlayBack),
          ),
          const Spacer(),
          BlocSelector<NowPlayingCubit, NowPlayingState, bool>(
            bloc: sl<NowPlayingCubit>(),
            selector: (state) {
              return state.isPlaying;
            },
            builder: (context, isPlaying) {
              return GestureDetector(
                onTap: sl<NowPlayingCubit>().handlePlayPause,
                child: Container(
                  height: 72,
                  width: 72,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                      height: 28,
                      width: 28,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          AppColors.lightBackground, BlendMode.srcIn),
                      isPlaying ? AppVectors.icPlaying : AppVectors.btnPlay),
                ),
              );
            },
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
                height: 26,
                width: 26,
                fit: BoxFit.cover,
                AppVectors.icPlayNext),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
                height: 24, width: 24, fit: BoxFit.cover, AppVectors.icShuffle),
          ),
        ],
      ),
    );
  }
}