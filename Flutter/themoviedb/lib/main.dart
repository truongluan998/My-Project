import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themoviedb/route.dart';
import 'package:themoviedb/screen/movie/movie_screen.dart';
import 'package:themoviedb/theme.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: MovieScreen(),
      initialRoute: MovieScreen.routeName,
      routes: routes,
    );
  }
}

