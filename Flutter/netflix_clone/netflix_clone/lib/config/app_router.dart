import 'package:flutter/material.dart';

import '../const/constants.dart';
import '../screens/home/home_screen.dart';
import '../screens/on_boarding/help_screen/help_screen.dart';
import '../screens/on_boarding/on_boarding_screen.dart';
import '../screens/on_boarding/sign_in/sign_in_already_have_email.dart';
import '../screens/on_boarding/sign_in/sign_in_screen.dart';
import '../screens/on_boarding/sign_up/sign_up_screen.dart';
import '../screens/splash_screen.dart';

mixin AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return _createAnimationRoute(const SplashScreen(), settings);
      case OnBoardingScreen.routeName:
        return _createAnimationRoute(const OnBoardingScreen(), settings);
      case HomeScreen.routeName:
        return _createAnimationRoute(const HomeScreen(), settings);
      case HelpScreen.routeName:
        return _createAnimationRoute(const HelpScreen(), settings);
      case SignInScreen.routeName:
        return _createAnimationRoute(const SignInScreen(), settings);
      case SignInAlreadyHaveEmailScreen.routeName:
        return _createAnimationRoute(
          const SignInAlreadyHaveEmailScreen(),
          settings,
        );
      case SignUpScreen.routeName:
        return _createAnimationRoute(const SignUpScreen(), settings);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(LabelConstant.ERROR),
          ),
        ),
        settings: const RouteSettings(name: '/error'),
      );
}

Route _createAnimationRoute(Widget screen, RouteSettings settings) =>
    PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: DimensionConstant.DURATION_700_MILLISECONDS,
      ),
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
