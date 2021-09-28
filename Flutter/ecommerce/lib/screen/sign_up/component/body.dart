import 'package:ecommerce/component/socal_card.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screen/sign_up/component/sign_up_form.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02,),
              Text(
                'Register Account',
                style: headingStyle,
              ),
              Text(
                'Complete your details or continue \nwith social media',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.07,),// 8 % of screen height
              SignUpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.07,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocalCard(
                    icon: 'assets/icons/google-icon.svg',
                    press: () {},
                  ),
                  SocalCard(
                    icon: 'assets/icons/facebook-2.svg',
                    press: () {},
                  ),
                  SocalCard(
                    icon: 'assets/icons/twitter.svg',
                    press: () {},
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20),),
              Text('By Continue your confirm that you agree \n with our Term and Condition',
              textAlign: TextAlign.center,),
              SizedBox(height: SizeConfig.screenHeight * 0.02,),
            ],
          ),
        ),
      ),
    );
  }
}


