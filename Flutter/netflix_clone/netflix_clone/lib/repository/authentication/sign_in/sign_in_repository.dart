import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/providers/authentication_firebase_provider.dart';
import '../../../data/providers/facebook_sign_in_provider.dart';
import '../../../data/providers/google_sign_in_provider.dart';
import '../../../models/authentication_details.dart';

class SignInRepository {
  SignInRepository({
    required AuthenticationFirebaseProvider authenticationFirebaseProvider,
    GoogleSignInProvider? googleSignInProvider,
    FacebookSignInProvider? facebookSignInProvider,
  })  : _authenticationFirebaseProvider = authenticationFirebaseProvider,
        _googleSignInProvider = googleSignInProvider,
        _facebookSignInProvider = facebookSignInProvider;

  final AuthenticationFirebaseProvider _authenticationFirebaseProvider;
  final GoogleSignInProvider? _googleSignInProvider;
  final FacebookSignInProvider? _facebookSignInProvider;

  Stream<AuthenticationDetail> getAuthDetailStream() =>
      _authenticationFirebaseProvider
          .getAuthStates()
          .map((user) => _getAuthCredentialFromFirebaseUser(user: user));

  Future<AuthenticationDetail?> authenticateWithGoogle() async {
    final user = await _authenticationFirebaseProvider.login(
      credential: await _googleSignInProvider!.googleLogin(),
    );
    return _getAuthCredentialFromFirebaseUser(user: user);
  }

  Future<AuthenticationDetail?> authenticateWithFacebook() async {
    final user = await _authenticationFirebaseProvider.login(
      credential: await _facebookSignInProvider!.facebookLogin(),
    );
    return _getAuthCredentialFromFirebaseUser(user: user);
  }

  Future<AuthenticationDetail?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final user = await _authenticationFirebaseProvider
        .signInWithEmailAndPassword(email: email, password: password);
    if (user != null) {
      return _getAuthCredentialFromFirebaseUser(user: user);
    }
  }

  Future<void> unAuthenticate() async {
    await _googleSignInProvider!.googleLogout();
    await _facebookSignInProvider!.facebookLogout();
    await _authenticationFirebaseProvider.logout();
  }

  AuthenticationDetail _getAuthCredentialFromFirebaseUser({
    required User? user,
  }) {
    AuthenticationDetail authDetail;
    if (user != null) {
      authDetail = AuthenticationDetail(
        isValid: true,
        uid: user.uid,
        email: user.email,
        photoUrl: user.photoURL,
        name: user.displayName,
      );
    } else {
      authDetail = const AuthenticationDetail(isValid: false);
    }
    return authDetail;
  }
}
