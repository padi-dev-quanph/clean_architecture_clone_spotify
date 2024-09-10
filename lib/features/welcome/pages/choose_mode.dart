import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/theme/theme_cubit.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_button.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_images.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_clean_architecture_spotify/features/welcome/widgets/background_container.dart';
import 'package:flutter_clean_architecture_spotify/features/welcome/widgets/mode_item.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundContainer(url: AppImages.chooseModeBG),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              child: Column(
                children: [
                  _buildLogo(),
                  const Spacer(),
                  _buildContent(),
                  const SizedBox(
                    height: 40,
                  ),
                  BasicAppButton(
                      height: 92,
                      onPressed: () {
                        GoRouter.of(context)
                            .pushNamed(AppRoutes.signUpOrSignIn);
                      },
                      title: 'Continue')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _buildContent() {
    return Column(
      children: [
        // title
        const Text(
          "Choose Mode",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
            fontSize: 26,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // Description
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ModeItem(
              title: 'Dark Mode',
              icon: AppVectors.moon,
              onPressed: () {
                sl<ThemeCubit>().updateTheme(ThemeMode.dark);
              },
            ),
            ModeItem(
              title: 'Light Mode',
              icon: AppVectors.sun,
              onPressed: () {
                sl<ThemeCubit>().updateTheme(ThemeMode.light);
              },
            ),
          ],
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
