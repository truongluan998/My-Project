import 'package:login_project/models/user.dart';

import '../repository/authentication_repository.dart';

class AuthenticationService extends AuthenticationRepository {
  @override
  Future<bool> checkUser(User? user) async {
    try {
      if (user != null &&
          user.accessToken != null &&
          user.accessToken == 'access_token') {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  @override
  Future<User?> loginUser(
    String? email,
    String? password,
  ) async {
    try {
      if (email != null &&
          password != null &&
          (email == 'demo@gmail.com' && password == 'demo123')) {
        final user = User(1, email, password, 'access_token');
        return user;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
