import 'package:flutter_clean_architecture_spotify/common/app_navigator.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:go_router/go_router.dart';

class SignUpNavigator extends AppNavigator {
  SignUpNavigator({required super.context});

  void goToSignInPage() {
    GoRouter.of(context).pushReplacementNamed(AppRoutes.login);
  }
}
