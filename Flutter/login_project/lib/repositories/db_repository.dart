import 'package:login_project/model/user.dart';
import 'package:login_project/services/db_service.dart';

import '../dependencies/app_dependencies.dart';

class DBRepository {
  final _authenticationService = AppDependencies.getIt.get<DbService>();

  Future<void> newUser(User user) async =>
      await _authenticationService.newUser(user);

  Future<User?> getUser() async =>
      await _authenticationService.getUser();
}
