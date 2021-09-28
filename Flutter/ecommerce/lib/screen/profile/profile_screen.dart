import 'package:ecommerce/component/custom_bottom_nav_bar.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/enum.dart';
import 'package:ecommerce/screen/home/home_screen.dart';
import 'package:ecommerce/screen/profile/component/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}

