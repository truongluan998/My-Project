import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:netflix_clone/blocs/authentication_bloc/sign_up/check_email_exits/check_email_exits_bloc.dart';
import 'package:netflix_clone/blocs/authentication_bloc/sign_up/sign_up_account/sign_up_bloc.dart';
import 'package:netflix_clone/repository/authentication/sign_up/sign_up_repository.dart';
import 'package:url_strategy/url_strategy.dart';

import 'blocs/authentication_bloc/authentication/authentication_bloc.dart';
import 'blocs/authentication_bloc/sign_in/sign_in_bloc.dart';
import 'blocs/film_overview_bloc/film_overview_bloc.dart';
import 'blocs/observers/app_bloc_observer.dart';
import 'config/app_router.dart';
import 'const/constants.dart';
import 'data/providers/authentication_firebase_provider.dart';
import 'data/providers/facebook_sign_in_provider.dart';
import 'data/providers/google_sign_in_provider.dart';
import 'repository/authentication/sign_in/sign_in_repository.dart';
import 'screens/splash_screen.dart';
import 'theme/netflix_clone_theme.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then(
    (_) {
      // if (kIsWeb) {
      //   // initialiaze the facebook javascript SDK
      //   FacebookAuth.instance.webInitialize(
      //     appId: '415798283599016',
      //     cookie: true,
      //     xfbml: true,
      //     version: 'v11.0',
      //   );
      // }
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => FilmOverviewBloc(FilmOverviewInitial()),
          ),
          BlocProvider(
            create: (_) => AuthenticationBloc(
              signInRepository: SignInRepository(
                authenticationFirebaseProvider: AuthenticationFirebaseProvider(
                  firebaseAuth: FirebaseAuth.instance,
                ),
                googleSignInProvider:
                    GoogleSignInProvider(googleSignIn: GoogleSignIn()),
                facebookSignInProvider:
                    FacebookSignInProvider(facebookAuth: FacebookAuth.instance),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => SignInBloc(
              signInRepository: SignInRepository(
                authenticationFirebaseProvider: AuthenticationFirebaseProvider(
                  firebaseAuth: FirebaseAuth.instance,
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => CheckEmailExitsBloc(
              signUpRepository: SignUpRepository(
                authenticationFirebaseProvider: AuthenticationFirebaseProvider(
                  firebaseAuth: FirebaseAuth.instance,
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpBloc(
              signUpRepository: SignUpRepository(
                authenticationFirebaseProvider: AuthenticationFirebaseProvider(
                  firebaseAuth: FirebaseAuth.instance,
                ),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          title: LabelConstant.TITLE_APP,
          debugShowCheckedModeBanner: false,
          theme: NetflixCloneTheme.buildTheme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      );
}
