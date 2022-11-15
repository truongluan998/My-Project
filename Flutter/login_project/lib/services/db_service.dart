import '../model/user.dart';

abstract class DbService {
  Future<void> newUser(User user);
  Future<User?> getUser();
}