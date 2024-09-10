import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_svg/svg.dart';

class ModeItem extends StatelessWidget {
  const ModeItem({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
  });

  final String title;
  final String icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: 73,
              width: 73,
              decoration: BoxDecoration(
                  color: AppColors.darkGrey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.textWhite,
                  )),
              alignment: Alignment.center,
              child: SvgPicture.asset(height: 29, width: 25, icon),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
