import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/common/helpers/is_dark_mode.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_images.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_svg/svg.dart';

class SongItem extends StatelessWidget {
  const SongItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                    height: 185,
                    width: 147,
                    fit: BoxFit.cover,
                    AppImages.authBG),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 20,
                child: Container(
                  height: 29,
                  width: 29,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode
                          ? AppColors.textGreyLight
                          : AppColors.textGreyDark),
                  child: Center(
                    child: SvgPicture.asset(
                        height: 14, width: 14, AppVectors.btnPlay),
                  ),
                )),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Song Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                'Artist Name',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        )
      ],
    );
  }
}
