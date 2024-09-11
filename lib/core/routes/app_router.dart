import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_in/sign_in.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_up/sign_up.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_in_or_sign_up/signup_or_signin.dart';
import 'package:flutter_clean_architecture_spotify/features/music/home/home.dart';
import 'package:flutter_clean_architecture_spotify/features/welcome/pages/choose_mode.dart';
import 'package:flutter_clean_architecture_spotify/features/welcome/pages/get_started.dart';
import 'package:flutter_clean_architecture_spotify/features/welcome/pages/splash.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final navigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(routes: _routes);

  static final _routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      name: AppRoutes.splash,
      pageBuilder: (context, state) => WebPage(child: const SplashPage()),
    ),
    GoRoute(
      path: AppRoutes.getStarted,
      name: AppRoutes.getStarted,
      pageBuilder: (context, state) => WebPage(child: const GetStartedPage()),
    ),
    GoRoute(
      path: AppRoutes.chooseMode,
      name: AppRoutes.chooseMode,
      pageBuilder: (context, state) => WebPage(child: const ChooseModePage()),
    ),
    GoRoute(
      path: AppRoutes.signUpOrSignIn,
      name: AppRoutes.signUpOrSignIn,
      pageBuilder: (context, state) => WebPage(child: const SignupOrSignin()),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: AppRoutes.login,
      pageBuilder: (context, state) => WebPage(child: const SignInPage()),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: AppRoutes.register,
      pageBuilder: (context, state) => WebPage(child: const SignUpPage()),
    ),
    GoRoute(
      path: AppRoutes.home, 
      name: AppRoutes.home,
      pageBuilder: (context, state) => WebPage(child: const HomePage())
    )
  ];
}

class WebPage extends CustomTransitionPage {
  final TransitionType transitionType;
  WebPage({required super.child, this.transitionType = TransitionType.slide})
      : super(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (transitionType) {
              case TransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case TransitionType.scale:
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              case TransitionType.slide:
                return SlideTransition(
                  position: animation.drive(Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  )),
                  child: child,
                );
              case TransitionType.none:
                return child;
            }
          },
        );
}

enum TransitionType {
  fade,
  scale,
  slide,
  none,
}
