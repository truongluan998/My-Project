import 'package:flutter/material.dart';
import 'package:login_project/views/screens/category_screen.dart';
import 'package:login_project/views/screens/login_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return _createAnimationRoute(const LoginScreen(), settings);
      case CategoryScreen.routeName:
        return _createAnimationRoute(const CategoryScreen(), settings);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text('Page Error'),
          ),
        ),
        settings: const RouteSettings(name: '/error'),
      );
}

Route _createAnimationRoute(Widget screen, RouteSettings settings) => PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.easeIn;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
