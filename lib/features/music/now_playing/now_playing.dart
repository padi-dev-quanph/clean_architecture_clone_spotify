import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_cubit.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:flutter_clean_architecture_spotify/features/music/now_playing/widgets/slider_song.dart';
import 'package:flutter_clean_architecture_spotify/features/music/now_playing/widgets/song_action.dart';
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
              SliderSong(duration: widget.song.duration),
              const Spacer(),
              const SongAction(),
              const Spacer(),
              _buildShowLyric(),
            ],
          ),
        ),
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
}
