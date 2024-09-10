import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_in/sign_in_cubit.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_in/sign_in_state.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/load_status.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/sign_in_type.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_button.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_clean_architecture_spotify/data/models/sign_in_email_and_password_req.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_in/sign_in_navigator.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';
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
    return BlocProvider<SignInCubit>(
      create: (context) => sl(),
      child: const Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({
    super.key,
  });

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = SignInNavigator(context: context);
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.loadStatus == LoadStatus.loading) {
          navigator.showLoadingOverlay();
        } else {
          if (state.loadStatus == LoadStatus.failed) {
            navigator.error(state.message);
          } else if (state.loadStatus == LoadStatus.success) {
            navigator.success(state.message);
            navigator.goToMain();
          }
          navigator.hideLoadingOverlay();
        }
      },
      child: Scaffold(
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
          onTap: () {
            context.read<SignInCubit>().signInWithGoogle();
          },
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
          final req = SignInEmailAndPasswordReq(
              email: _emailController.text,
              password: _passwordController.text,
              signInType: SignInType.useEmailAndPassword);
          context.read<SignInCubit>().signInWithEmailAndPassword(req);
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
            controller: _emailController,
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
            controller: _passwordController,
            obscureText: true,
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
