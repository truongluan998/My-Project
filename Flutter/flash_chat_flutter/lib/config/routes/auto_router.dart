import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:auto_route/annotations.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Widget,Route',
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