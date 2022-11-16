import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_project/login_app.dart';
import 'package:login_project/theme/login_app_color.dart';

import 'dependencies/app_dependencies.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: LoginAppColor.transparent,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  AppDependencies.configureDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
        ],
        path: 'assets/translations',
        startLocale: const Locale('en', 'US'),
        child: const LoginApp(),
      ),
    ),
  );
}
