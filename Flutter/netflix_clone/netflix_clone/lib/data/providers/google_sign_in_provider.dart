import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  GoogleSignInProvider({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;

  final GoogleSignIn _googleSignIn;

  Future<AuthCredential?> googleLogin() async {
    final googleSignInAccount =
        await _googleSignIn.signIn().catchError((error) {
      print('Error $error');
    });
    if (googleSignInAccount != null) {
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return authCredential;
    } else {
      return null;
    }
  }

  Future<void> googleLogout() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
  }
}
