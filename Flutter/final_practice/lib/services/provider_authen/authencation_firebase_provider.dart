import 'package:firebase_auth/firebase_auth.dart';

import '../authentication_service.dart';

class AuthenticationFirebaseProvider extends AuthenticationService {
  final FirebaseAuth firebaseAuth ;

  AuthenticationFirebaseProvider(this.firebaseAuth);

  @override
  Stream<User?> getAuthStates() => firebaseAuth.authStateChanges();

  @override
  Future<User?> signInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) async {
    if (email != null && password != null) {
      final user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user.credential != null) {
        return user.user;
      } else {
        return null;
      }
    }
  }

  @override
  Future<bool> signUpWithEmailAndPassword({
    required String? fullName,
    required String? email,
    required String? password,
  }) async {
    if (fullName != null && email != null && password != null) {
      final checkEmail = await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (checkEmail.isEmpty) {
        await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((user) async {
          await user.user!.updateDisplayName(fullName);
          await user.user!.reload();
        });
        return true;
      }
      return false;
    }
    return false;
  }

  @override
  User? getCurrentUser() {
    if (firebaseAuth.currentUser != null) {
      return firebaseAuth.currentUser;
    }
  }
}
