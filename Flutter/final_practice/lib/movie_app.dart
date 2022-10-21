import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'blocs/connection/check_internet_connection_bloc.dart';
import 'blocs/connection/check_internet_connection_event.dart';
import 'blocs/connection/check_internet_connection_state.dart';
import 'constants/constants.dart';
import 'dependencies/app_dependencies.dart';
import 'router/app_router.dart';
import 'screens/splash_screen.dart';
import 'theme/final_practice_theme.dart';
import 'utility/utility.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> with AfterLayoutMixin {
  late final Utils _utils;
  late final CheckInternetConnectionBloc _checkInternetConnectionBloc;

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  @override
  void initState() {
    _utils = AppDependencies.injector.get<Utils>();
    _checkInternetConnectionBloc =
        AppDependencies.injector.get<CheckInternetConnectionBloc>();
    _checkInternetConnectionBloc.add(CheckInternetFirstTimeEvent());
    super.initState();
  }

  Future<void> _checkInternet() async {
    var checkFirstTime = true;
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((_) async {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        _checkInternetConnectionBloc.add(LostInternetEvent());
      }
      if (connectivityResult != ConnectivityResult.none) {
        _checkInternetConnectionBloc.add(ReconnectInternetEvent());
      }
    });
    _checkInternetConnectionBloc.stream.listen((state) {
      if (state is CheckInternetConnectionInitial) {
        if(checkFirstTime) {
          if (state.message != null) {
            _utils.showToast(state.message!);
          }
          checkFirstTime = false;
        }
      }
      if (state is LostInternetState) {
        _utils.showToast(state.message);
      }
      if (state is ReconnectTheInternetState) {
        if(!checkFirstTime) {
          _utils.showToast(state.message);
        }
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: LabelConstant.TITLE_APP,
        debugShowCheckedModeBanner: false,
        theme: FinalPracticeTheme.buildTheme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      );

  @override
  void afterFirstLayout(BuildContext context) {
    _checkInternet();
  }
}
