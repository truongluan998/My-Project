import 'package:ecommerce/component/custom_bottom_nav_bar.dart';
import 'package:ecommerce/enum.dart';
import 'package:ecommerce/screen/home/component/body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home,),
    );
  }
}
