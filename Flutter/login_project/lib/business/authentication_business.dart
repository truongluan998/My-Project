import 'package:login_project/repository/authentication_repository.dart';
import '../dependencies/app_dependencies.dart';
import '../model/user.dart';

class AuthenticationBusiness {
  final _authenticationService =
      AppDependencies.getIt.get<AuthenticationRepository>();

  Future<User?> loginUser(String? email, String password) async =>
      await _authenticationService.loginUser(email, password);

  Future<bool> checkUser(User? user) async =>
      await _authenticationService.checkUser(user);
}
