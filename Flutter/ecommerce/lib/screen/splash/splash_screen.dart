import 'package:ecommerce/screen/splash/component/body.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    //Call it from size config
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
