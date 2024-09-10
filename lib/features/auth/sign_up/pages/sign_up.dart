import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/common/app_navigator.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/load_status.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_button.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_clean_architecture_spotify/data/models/create_user_req.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
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
  late TextEditingController _fnameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _fnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _fnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = AppNavigator(context: context);
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.loadStatus == LoadStatus.loading) {
          navigator.showLoadingOverlay();
        } else {
          if (state.loadStatus == LoadStatus.failed) {
            navigator.error(state.message);
          } else {
            navigator.success(state.message);
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
                _buildTitle(),
                const SizedBox(
                  height: 40,
                ),
                _buildForm(),
                const SizedBox(
                  height: 20,
                ),

                _signUpButton(),

                // Divider
                const SizedBox(
                  height: 20,
                ),
                _buildDivider(),

                // Social Login
                _buildSocialLogin(),

                const SizedBox(
                  height: 20,
                ),
                _buildSwitchSingIn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildSwitchSingIn(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(children: [
          const TextSpan(
              text: 'Do You Have An Account ',
              style: TextStyle(
                fontSize: 14,
              )),
          TextSpan(
              text: 'Sign In',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 14,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  GoRouter.of(context).pushReplacement(AppRoutes.login);
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

  BasicAppButton _signUpButton() => BasicAppButton(
      onPressed: () {
        final req = CreateUserReq(
            fullName: _fnameController.text,
            email: _emailController.text,
            password: _passwordController.text);
        context.read<SignUpCubit>().signup(req);
      },
      title: 'Create account');

  Form _buildForm() {
    return Form(
        child: Column(
      children: [
        TextField(
            controller: _fnameController,
            decoration: InputDecoration(
                hintText: 'Full Name',
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
            controller: _emailController,
            decoration: InputDecoration(
                hintText: 'Enter Email',
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
            'Register',
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
