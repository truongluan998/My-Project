import 'package:login_project/services/authentication_service.dart';
import '../dependencies/app_dependencies.dart';
import '../model/user.dart';

class AuthenticationRepository {
  final _authenticationService =
      AppDependencies.getIt.get<AuthenticationService>();

  Future<User?> loginUser(String? email, String password) async =>
      await _authenticationService.loginUser(email, password);

  Future<bool> checkUser(User? user) async =>
      await _authenticationService.checkUser(user);
}
