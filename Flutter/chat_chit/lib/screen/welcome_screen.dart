import 'package:chat_chit/bloc/navigator/navigator_bloc.dart';
import 'package:chat_chit/const/constants.dart';
import 'package:chat_chit/dependencies/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _navigatorBloc = AppDependencies.injector.get<MyNavigatorBloc>();

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: BlocListener<MyNavigatorBloc, MyNavigatorState>(
              bloc: _navigatorBloc,
              listener: (context, state) {
                if (state is LoadedLoginScreen) {
                  print('Go To Login');
                }
                if (state is LoadedLoginScreen) {
                  print('Go To Register');
                }
              },
              child: Column(
                children: [
                  const Text('Welcome Screen'),
                  ElevatedButton(
                      onPressed: () =>
                          _navigatorBloc.add(GoToLoginEvent(context: context)),
                      child: const Text('Go to Login Screen')),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  ElevatedButton(
                      onPressed: () => _navigatorBloc
                          .add(GoToRegisterEvent(context: context)),
                      child: const Text('Go to Register Screen')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
