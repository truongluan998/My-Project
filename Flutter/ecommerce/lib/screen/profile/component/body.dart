import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screen/profile/component/profile_menu.dart';
import 'package:ecommerce/screen/profile/component/profile_pic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20,),
        ProfileMenu(icon: 'assets/icons/User Icon.svg', text: 'My Account', press: () {},),
        ProfileMenu(icon: 'assets/icons/Bell.svg', text: 'Notifications', press: () {},),
        ProfileMenu(icon: 'assets/icons/Settings.svg', text: 'Settings', press: () {},),
        ProfileMenu(icon: 'assets/icons/Question mark.svg', text: 'Help Center', press: () {},),
        ProfileMenu(icon: 'assets/icons/Log out.svg', text: 'Logout', press: () {},),
      ],
    );
  }
}

