import 'package:auto_route/auto_route.dart';
import 'package:chat_chit/config/auto_route/auto_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRoute = AppRouter();
    return  MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Chat Chit',
      routerDelegate: AutoRouterDelegate(_appRoute),
      routeInformationParser: _appRoute.defaultRouteParser(),
    );
  }
}

