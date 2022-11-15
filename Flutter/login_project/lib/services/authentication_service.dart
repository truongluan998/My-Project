import 'package:login_project/model/user.dart';

abstract class AuthenticationService {
  Future<User?> loginUser(String? email, String? password);
  Future<bool> checkUser(User? user);
}