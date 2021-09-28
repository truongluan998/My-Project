// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../screens/chat_screen.dart' as _i6;
import '../../screens/login_screen.dart' as _i4;
import '../../screens/registration_screen.dart' as _i5;
import '../../screens/welcome_screen.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    WelcomeScreen.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.WelcomeScreen());
    },
    LoginScreen.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.LoginScreen());
    },
    RegistrationScreen.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.RegistrationScreen());
    },
    ChatScreen.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.ChatScreen());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: '/welcome', fullMatch: true),
        _i1.RouteConfig(WelcomeScreen.name, path: '/welcome'),
        _i1.RouteConfig(LoginScreen.name, path: '/login'),
        _i1.RouteConfig(RegistrationScreen.name, path: '/registration'),
        _i1.RouteConfig(ChatScreen.name, path: '/chat')
      ];
}

class WelcomeScreen extends _i1.PageRouteInfo<void> {
  const WelcomeScreen() : super(name, path: '/welcome');

  static const String name = 'WelcomeScreen';
}

class LoginScreen extends _i1.PageRouteInfo<void> {
  const LoginScreen() : super(name, path: '/login');

  static const String name = 'LoginScreen';
}

class RegistrationScreen extends _i1.PageRouteInfo<void> {
  const RegistrationScreen() : super(name, path: '/registration');

  static const String name = 'RegistrationScreen';
}

class ChatScreen extends _i1.PageRouteInfo<void> {
  const ChatScreen() : super(name, path: '/chat');

  static const String name = 'ChatScreen';
}
