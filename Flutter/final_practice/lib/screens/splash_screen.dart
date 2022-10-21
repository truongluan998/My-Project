import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication/authentication_bloc.dart';
import '../blocs/authentication/authentication/authentication_event.dart';
import '../blocs/authentication/authentication/authentication_state.dart';
import '../config/size_config.dart';
import '../constants/constants.dart';
import '../dependencies/app_dependencies.dart';
import '../utility/exception.dart';
import '../utility/utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/splash';

  static Route route() => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthenticationBloc _authenticationBloc;
  late final Utils _utils;

  @override
  void initState() {
    _authenticationBloc = AppDependencies.injector.get<AuthenticationBloc>();
    _utils = AppDependencies.injector.get<Utils>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: _utils.buildBackgroundAuthenScreen(),
        child: Center(
          child: BlocConsumer(
            bloc: _authenticationBloc,
            listener: (context, state) {
              if (state is AuthenticationFailureState) {
                if (state.exception == ListExceptionAuthentication.noUser) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/sign_in',
                    (route) => false,
                  );
                }
                if (state.exception ==
                    ListExceptionAuthentication.failAuthentication) {
                  _utils.showToast(state.message);
                }
              }
              if (state is AuthenticationSuccessState) {
                _utils
                    .getPrefsToOpenOnBoarding('key_on_boarding')
                    .then((value) {
                  if (value == true) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/main',
                      (route) => false,
                    );
                    _utils.showToast(
                      '${LabelConstant.WELCOME}'
                      '${state.authenticationDetail?.fullName ?? ''}',
                    );
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/on_boarding',
                      (route) => false,
                    );
                    _utils.showToast(
                      '${LabelConstant.WELCOME}'
                      '${state.authenticationDetail?.fullName ?? ''}',
                    );
                  }
                });
              }
            },
            buildWhen: (next, result) {
              if (result is AuthenticationSuccessState) {
                return false;
              } else {
                return true;
              }
            },
            builder: (context, state) {
              if (state is AuthenticationInitialState) {
                _authenticationBloc.add(AuthenticationStartedEvent());
              }
              if (state is AuthenticationLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
