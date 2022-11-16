import 'package:flutter/material.dart';
import 'package:login_project/business/authentication_business.dart';
import 'package:login_project/business/db_business.dart';
import 'package:login_project/dependencies/app_dependencies.dart';
import 'package:login_project/utils/enum.dart';

import '../utils/validator.dart';

class AuthenticationController extends ChangeNotifier {
  final _authenticationBusiness = AppDependencies.getIt.get<AuthenticationBusiness>();
  final _dbBusiness = AppDependencies.getIt.get<DBBusiness>();

  ListStatusAuthentication statusAuthentication = ListStatusAuthentication.initial;

  bool isLoading = false;
  bool isShowPass = false;

  Future<void> checkUser() async {
    try {
      isLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1000));
      final user = await _dbBusiness.getUser();
      if (user != null) {
        final isValidUser = await _authenticationBusiness.checkUser(user);
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
    final userData = await _authenticationBusiness.loginUser(email, password);
    if (!Validators.isValidEmail(email)) {
      isLoading = false;
      statusAuthentication = ListStatusAuthentication.wrongEmail;
      notifyListeners();
    } else if (userData != null) {
      await _dbBusiness.newUser(userData).whenComplete(() {
        isLoading = false;
        statusAuthentication = ListStatusAuthentication.success;
        notifyListeners();
      }).onError((error, stackTrace) {
        isLoading = false;
        statusAuthentication = ListStatusAuthentication.fail;
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
