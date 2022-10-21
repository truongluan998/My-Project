import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInProvider {
  FacebookSignInProvider({required FacebookAuth facebookAuth})
      : _facebookAuth = facebookAuth;

  final FacebookAuth _facebookAuth;

  Future<AuthCredential?> facebookLogin() async {
    final facebookSignInAccount = await _facebookAuth.login(
      permissions: ['email', 'public_profile', 'user_birthday'],
    ).catchError((error) {
      print('Error $error');
    });
    if (facebookSignInAccount.accessToken != null) {
      final authCredential = FacebookAuthProvider.credential(
        facebookSignInAccount.accessToken!.token,
      );
      return authCredential;
    } else {
      return null;
    }
  }

  Future<void> facebookLogout() async {
    await _facebookAuth.logOut();
  }
}
