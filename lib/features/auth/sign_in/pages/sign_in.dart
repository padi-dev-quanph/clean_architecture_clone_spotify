import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_button.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: _buildLogo(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // title
              _buildTitle(),
              const SizedBox(
                height: 40,
              ),
              _buildForm(),
              _recoveryButton(),

              _signInButton(context),

              // Divider
              const SizedBox(
                height: 20,
              ),
              _buildDivider(),

              const SizedBox(
                height: 20,
              ),

              // Social Login
              _buildSocialLogin(),

              const SizedBox(
                height: 20,
              ),
              _buildSwitchToSignUp(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildSwitchToSignUp(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(children: [
          const TextSpan(
              text: 'Not A Member ',
              style: TextStyle(
                fontSize: 14,
              )),
          TextSpan(
              text: 'Register Now',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 14,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  GoRouter.of(context).pushReplacement(AppRoutes.register);
                })
        ]),
      ),
    );
  }

  Row _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppVectors.icGoogle,
              height: 36,
              width: 29,
            ),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppVectors.icApple,
              height: 36,
              width: 29,
            ),
          ),
        ),
      ],
    );
  }

  Row _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.textGreyDark,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Or',
            style: TextStyle(color: AppColors.textBlack),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.textGreyDark,
          ),
        ),
      ],
    );
  }

  BasicAppButton _signInButton(BuildContext context) {
    return BasicAppButton(
        onPressed: () {
          GoRouter.of(context).pushReplacementNamed(AppRoutes.home);
        },
        title: 'Sign In');
  }

  TextButton _recoveryButton() {
    return TextButton(
        onPressed: () {},
        child: const Text(
          'Recovery password',
          style: TextStyle(fontSize: 14),
        ));
  }

  Form _buildForm() {
    return Form(
        child: Column(
      children: [
        TextField(
            decoration: InputDecoration(
                hintText: 'Enter Username Or Email',
                hintStyle: const TextStyle(color: AppColors.textGreyDark),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textGreyDark),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.textGreyDark),
                  borderRadius: BorderRadius.circular(30),
                ))),
        const SizedBox(
          height: 20,
        ),
        TextField(
            decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(color: AppColors.textGreyDark),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textGreyDark),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.textGreyDark),
                  borderRadius: BorderRadius.circular(30),
                ))),
      ],
    ));
  }

  Center _buildTitle() {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sign In',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: 'If you need any support ',
                style: TextStyle(fontSize: 12)),
            TextSpan(
                text: 'Click Here',
                style: TextStyle(color: AppColors.primary, fontSize: 12))
          ])),
        ],
      ),
    );
  }

  SvgPicture _buildLogo() {
    return SvgPicture.asset(height: 33, AppVectors.logo);
  }
}
