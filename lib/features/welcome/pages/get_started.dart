import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_button.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_images.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_clean_architecture_spotify/features/welcome/widgets/background_container.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundContainer(url: AppImages.introBG),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              child: Column(
                children: [
                  _buildLogo(),
                  const Spacer(),
                  _buildContent(),
                  const SizedBox(
                    height: 20,
                  ),
                  BasicAppButton(
                      height: 92,
                      onPressed: () {
                        GoRouter.of(context).pushNamed(AppRoutes.chooseMode);
                      },
                      title: 'Get Started')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _buildContent() {
    return const Column(
      children: [
        // title
        Text(
          "Enjoy listening to music",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
            fontSize: 26,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Description
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam. ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textGreyDark,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  Align _buildLogo() {
    return Align(
        alignment: Alignment.topCenter,
        child: SvgPicture.asset(height: 59, AppVectors.logo));
  }
}
