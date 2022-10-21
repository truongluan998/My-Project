import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationFirebaseProvider {
  AuthenticationFirebaseProvider({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  Stream<User?> getAuthStates() => _firebaseAuth.authStateChanges();

  Future<User?> login({required AuthCredential? credential}) async {
    if (credential != null) {
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    }
  }

  Future<User?> signInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) async {
    if (email != null && password != null) {
      final user = await _firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(user.credential != null) {
        return user.user;
      }
      else {
        return null;
      }
    }
  }

  Future<User?> signUpWithEmailAndPassword({
    required String? email,
    required String? password,
  }) async {
    if (email != null && password != null) {
      final user = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(user.credential != null) {
        return user.user;
      }
      else {
        return null;
      }
    }
  }

  Future<bool?> checkIfEmailInUser({required String emailAddress}) async {
    try {
      final email = await _firebaseAuth
          .fetchSignInMethodsForEmail(emailAddress)
          .catchError((error) {
        print('Error $error');
      });
      if (email.isNotEmpty) {
        // email existing
        return true;
      } else {
        // email is not in use
        return false;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
