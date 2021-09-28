import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/bloc/navigator/navigator_bloc.dart';
import 'package:flash_chat/dependencies/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_button.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  late NavigatorBloc _navigatorBloc;

  @override
  void initState() {
    _navigatorBloc = AppDependencies.injector.get<NavigatorBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _navigatorBloc,
      listener: (context, state) {
        if(state is LoadedLoginScreen) {
          print('Go To Login');
        }
        if(state is LoadedRegisterScreen) {
          print('Go To Register');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/logo.png'),
                  height: 60.0,
                ),
              ),
              TypewriterAnimatedTextKit(
                text: ['Flash Chat'],
                speed: const Duration(milliseconds: 200),
                textStyle: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 48.0,
          ),
          AppButton(
            text: 'Login',
            press: () {
              _navigatorBloc.add(GoToLoginEvent(context: context));
            },
            color: Colors.lightBlueAccent,
          ),
          AppButton(
            text: 'Register',
            press: () {
              _navigatorBloc.add(GoToRegisterEvent(context: context));
            },
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
