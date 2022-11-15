import 'package:login_project/model/user.dart';
import 'package:login_project/repository/db_repository.dart';
import '../dependencies/app_dependencies.dart';

class DBBusiness {
  final _authenticationService = AppDependencies.getIt.get<DBRepository>();

  Future<void> newUser(User user) async =>
      await _authenticationService.newUser(user);

  Future<User?> getUser() async =>
      await _authenticationService.getUser();
}
