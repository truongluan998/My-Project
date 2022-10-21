import 'package:firebase_auth/firebase_auth.dart';

import '../../model/authentication/authentication_details.dart';
import '../../services/authentication_service.dart';

class AuthenticationRepository {
  final AuthenticationService authenticationService;

  AuthenticationRepository(this.authenticationService);

  Stream<AuthenticationDetail> getAuthDetailStream() => authenticationService
      .getAuthStates()
      .map((user) => _getAuthCredentialFromFirebaseUser(user: user));

  Future<AuthenticationDetail?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final user = await authenticationService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (user != null) {
      return _getAuthCredentialFromFirebaseUser(user: user);
    }
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
        fullName: user.displayName,
      );
    } else {
      authDetail = const AuthenticationDetail(isValid: false);
    }
    return authDetail;
  }

  Future<bool> signUpWithEmailAndPassword(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final result = await authenticationService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );
      if (result == true) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {}
    return false;
  }
}
