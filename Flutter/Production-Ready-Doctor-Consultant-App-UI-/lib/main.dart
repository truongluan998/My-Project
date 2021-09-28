import 'package:doctor_app/constants.dart';
import 'package:doctor_app/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare - Doctor Consultation App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          textTheme: Theme.of(context).textTheme.apply(displayColor: textColor),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                  padding: EdgeInsets.all(defaultPadding))),
          inputDecorationTheme: InputDecorationTheme(
              border: textFieldBorder(),
              enabledBorder: textFieldBorder(),
              focusedBorder: textFieldBorder())),
      home: WelcomeScreen(),
    );
  }
}
