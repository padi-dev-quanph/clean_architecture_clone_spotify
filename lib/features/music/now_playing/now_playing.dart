import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:flutter_svg/svg.dart';

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

class Page extends StatelessWidget {
  const Page({super.key, required this.song});
  final SongEntity song;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 370,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: NetworkImage(
                          song.cover,
                        ),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 20,
              ),
              _buildSongInfo()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSongInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(song.artist,
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
