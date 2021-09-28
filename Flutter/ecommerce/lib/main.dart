import 'package:ecommerce/routs.dart';
import 'package:ecommerce/screen/splash/splash_screen.dart';
import 'package:ecommerce/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // initialRoute: SplashScreen.routerName,
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }


}
