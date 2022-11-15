import 'package:flutter/material.dart';
import 'package:login_project/dependencies/app_dependencies.dart';
import 'package:login_project/repositories/authentication_repository.dart';
import 'package:login_project/repositories/db_repository.dart';
import 'package:login_project/utils/enum.dart';

import '../utils/validator.dart';

class AuthenticationController extends ChangeNotifier {
  final _authenticationRepository =
      AppDependencies.getIt.get<AuthenticationRepository>();
  final _dbRepository = AppDependencies.getIt.get<DBRepository>();

  ListStatusAuthentication statusAuthentication =
      ListStatusAuthentication.initial;

  bool isLoading = false;
  bool isShowPass = false;

  Future<void> checkUser() async {
    try {
      isLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1000));
      final user = await _dbRepository.getUser();
      if (user != null) {
        final isValidUser = await _authenticationRepository.checkUser(user);
        if (isValidUser) {
          isLoading = false;
          statusAuthentication = ListStatusAuthentication.logged;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (_) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginUser(
    String email,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 1000));
    final userData = await _authenticationRepository.loginUser(email, password);
    if (!Validators.isValidEmail(email)) {
      isLoading = false;
      statusAuthentication = ListStatusAuthentication.wrongEmail;
      notifyListeners();
    } else if (userData != null) {
      await _dbRepository.newUser(userData).whenComplete(() {
        isLoading = false;
        statusAuthentication = ListStatusAuthentication.success;
        notifyListeners();
      });
    } else {
      isLoading = false;
      statusAuthentication = ListStatusAuthentication.fail;
      notifyListeners();
    }
  }

  void showPassword() {
    isShowPass = !isShowPass;
    notifyListeners();
  }
}
