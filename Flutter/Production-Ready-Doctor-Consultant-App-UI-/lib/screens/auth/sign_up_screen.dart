import 'package:doctor_app/constants.dart';
import 'package:doctor_app/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'component/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // avoid break layout when keyboard appear
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/icons/Sign_Up_bg.svg',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Account',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen())),
                            child: Text(
                              'Sign In!',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    SignUpForm(
                      formKey: _formKey,
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()) {
                               _formKey.currentState!.save();
                              }
                            }, child: Text('Sign Up')))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


