import '../model/user.dart';

abstract class DBRepository {
  Future<void> newUser(User user);
  Future<User?> getUser();
}