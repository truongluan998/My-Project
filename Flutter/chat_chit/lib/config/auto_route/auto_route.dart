import 'package:auto_route/annotations.dart';
import 'package:chat_chit/screen/chat_screen.dart';
import 'package:chat_chit/screen/login_screen.dart';
import 'package:chat_chit/screen/registration_screen.dart';
import 'package:chat_chit/screen/welcome_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: WelcomeScreen,
      initial: true,
      path: '/welcome',
    ),
    AutoRoute(
      page: LoginScreen,
      path: '/login',
    ),
    AutoRoute(
      page: RegistrationScreen,
      path: '/registration',
    ),
    AutoRoute(
      page: ChatScreen,
      path: '/chat',
    ),
  ],
)
class $AppRouter {}