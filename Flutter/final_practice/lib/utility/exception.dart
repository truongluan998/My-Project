import 'package:flutter/services.dart';

enum ListExceptionAuthentication {
  noUser,
  failAuthentication,
  logOutFail,
  emailInvalid,
  passwordInvalid,
  fullNameInvalid
}

String getExceptionText(Exception e) {
  if (e is PlatformException) {
    switch (e.message) {
      case 'There is no user record corresponding to this identifier. The user may have been deleted.':
        return 'User with this e-mail not found.';
      case 'The password is invalid or the user does not have a password.':
        return 'Invalid password.';
      case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
        return 'No internet connection.';
      case 'The email address is already in use by another account.':
        return 'Email address is already taken.';
      default:
        return 'Unknown error occured.';
    }
  } else {
    return 'Unknown error occured.';
  }
}
