import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/common/helpers/is_dark_mode.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_images.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SignupOrSignin extends StatefulWidget {
  const SignupOrSignin({super.key});

  @override
  State<SignupOrSignin> createState() => _SignupOrSigninState();
}

class _SignupOrSigninState extends State<SignupOrSignin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG),
          ),
          const Page(),
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: BasicAppbar(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                _buildLogo(),
                const SizedBox(
                  height: 40,
                ),
                _buildContent(context),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(AppRoutes.register);
                        },
                        child: Container(
                          height: 73,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                color: AppColors.textWhite,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(AppRoutes.login);
                        },
                        child: Container(
                          height: 73,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
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

  Column _buildContent(BuildContext context) {
    return Column(
      children: [
        // title
        const Text(
          "Enjoy listening to music",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // Description
        Text(
          'Spotify is a proprietary Swedish audio streaming and media services provider ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.isDarkMode
                ? AppColors.textGreyDark
                : AppColors.textGreyLight,
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
