import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:login_project/views/screens/login_screen.dart';
import 'package:login_project/theme/login_app_theme.dart';

import 'router/app_router.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LoginAppTheme.buildTheme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: LoginScreen.routeName,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
