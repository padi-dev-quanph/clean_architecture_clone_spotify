import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_cubit.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_state.dart';
import 'package:flutter_clean_architecture_spotify/common/helpers/time_ex.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';

class SliderSong extends StatelessWidget {
  const SliderSong({super.key, required this.duration});

  final num duration;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NowPlayingCubit, NowPlayingState, Duration>(
      bloc: sl<NowPlayingCubit>(),
      selector: (state) {
        return state.position;
      },
      builder: (context, position) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Slider(
              min: 0.0,
              max: getTimeFollowSecond(duration),
              value: position.inSeconds.toDouble(),
              onChanged: sl<NowPlayingCubit>().handleSeek,
              activeColor: AppColors.darkGrey,
            ),
            Row(
              children: [
                Text(formatDuration(position)),
                const Spacer(),
                Text(convertDurationFromNum(duration)),
              ],
            )
          ],
        );
      },
    );
  }
}
