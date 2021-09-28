import 'package:ecommerce/screen/cart/cart_screen.dart';
import 'package:ecommerce/screen/complete_profile/complete_profile_screen.dart';
import 'package:ecommerce/screen/details/details_screen.dart';
import 'package:ecommerce/screen/forgot_password/forgot_password_screen.dart';
import 'package:ecommerce/screen/home/home_screen.dart';
import 'package:ecommerce/screen/login_success/login_success_screen.dart';
import 'package:ecommerce/screen/otp/otp_screen.dart';
import 'package:ecommerce/screen/profile/profile_screen.dart';
import 'package:ecommerce/screen/sign_in/sign_in_screen.dart';
import 'package:ecommerce/screen/sign_up/sign_up_screen.dart';
import 'package:ecommerce/screen/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

// use name router
// all our router will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};