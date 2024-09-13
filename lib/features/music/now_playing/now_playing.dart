import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_cubit.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_state.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/common/helpers/time_ex.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage(
      {super.key, required this.song, required this.uniqueTag});

  final SongEntity song;
  final String uniqueTag;

  @override
  Widget build(BuildContext context) {
    return Page(
      song: song,
      uniqueTag: uniqueTag,
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.song, required this.uniqueTag});
  final SongEntity song;
  final String uniqueTag;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  late NowPlayingCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = sl<NowPlayingCubit>()..loadSong(widget.song);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: const Text(
          'Now Playing',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        action: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            height: 25,
            width: 25,
            AppVectors.icMore,
            colorFilter:
                const ColorFilter.mode(AppColors.darkGrey, BlendMode.srcIn),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildThumbnail(),
              const Spacer(),
              _buildSongInfo(),
              const Spacer(),
              _buildSlider(),
              const Spacer(),
              _buildButtonActions(),
              const Spacer(),
              _buildShowLyric(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonActions() {
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
            selector: (state) {
              return state.isPlaying;
            },
            builder: (context, isPlaying) {
              return GestureDetector(
                onTap: cubit.handlePlayPause,
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

  Widget _buildThumbnail() {
    return Hero(
      tag: '${widget.uniqueTag}${widget.song.cover}',
      child: Container(
        height: 370,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                image: NetworkImage(
                  widget.song.cover,
                ),
                fit: BoxFit.cover)),
      ),
    );
  }

  Widget _buildShowLyric() {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(AppRoutes.lyric, extra: {
          'song': widget.song,
        });
      },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SvgPicture.asset(AppVectors.icTopArrow),
            const Text(
              'Lyrics',
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSongInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.song.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(widget.song.artist,
                style: const TextStyle(
                  fontSize: 20,
                ))
          ],
        ),
        GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(AppVectors.icFavoriteBottomAppBar))
      ],
    );
  }

  Widget _buildSlider() {
    return BlocSelector<NowPlayingCubit, NowPlayingState, Duration>(
      selector: (state) {
        return state.position;
      },
      builder: (context, position) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Slider(
              min: 0.0,
              max: getTimeFollowSecond(widget.song.duration),
              value: position.inSeconds.toDouble(),
              onChanged: cubit.handleSeek,
              activeColor: AppColors.darkGrey,
            ),
            Row(
              children: [
                Text(formatDuration(position)),
                const Spacer(),
                Text(convertDurationFromNum(widget.song.duration)),
              ],
            )
          ],
        );
      },
    );
  }
}
