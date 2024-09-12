import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/core/helper/time_ex.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage({super.key, required this.song});

  final SongEntity song;

  @override
  Widget build(BuildContext context) {
    return Page(
      song: song,
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.song});
  final SongEntity song;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = true;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
    _player.positionStream.listen((p) {
      setState(() => position = p);
    });
  }

  @override
  void dispose() {
    super.dispose();
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
          GestureDetector(
            onTap: _handlePlayPause,
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
                  _isPlaying ? AppVectors.icPlaying : AppVectors.btnPlay),
            ),
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
    return Container(
      height: 370,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              image: NetworkImage(
                widget.song.cover,
              ),
              fit: BoxFit.cover)),
    );
  }

  Widget _buildShowLyric() {
    return Container(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Slider(
          min: 0.0,
          max: getTimeFollowSecond(widget.song.duration),
          value: position.inSeconds.toDouble(),
          onChanged: _handleSeek,
          activeColor: AppColors.darkGrey,
        ),
        Row(
          children: [
            Text(formatDuration(_player.position)),
            const Spacer(),
            Text(convertDurationFromNum(widget.song.duration)),
          ],
        )
      ],
    );
  }

  void _initializeTimer() async {
    await _player.setUrl(widget.song.content);
    await _player.play();
  }

  void _handlePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  void _handleSeek(double value) {
    _player.seek(Duration(seconds: value.toInt()));
  }
}
