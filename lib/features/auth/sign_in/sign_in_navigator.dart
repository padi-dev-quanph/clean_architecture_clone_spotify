import 'package:flutter_clean_architecture_spotify/common/app_navigator.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:go_router/go_router.dart';

class SignInNavigator extends AppNavigator {
  SignInNavigator({required super.context});

  void goToMain() {
    GoRouter.of(context).pushReplacementNamed(AppRoutes.home);
  }
}
