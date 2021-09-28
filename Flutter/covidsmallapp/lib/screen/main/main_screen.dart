import 'package:animations/animations.dart';
import 'package:covidsmallapp/screen/covid/covid_screen.dart';
import 'package:covidsmallapp/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _indexPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = <Widget>[
      HomeScreen(),
      CovidScreen(),
    ];
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            ),
        child: pageList[_indexPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexPage,
        onTap: (value) {
          setState(() {
            _indexPage = value;
          });
        },
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.coronavirus), label: 'Covid'),
        ],
      ),
    );
  }
}
