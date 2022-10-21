import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Stream<User?> getAuthStates();

  Future<User?> signInWithEmailAndPassword({
    required String? email,
    required String? password,
  });

  Future<bool> signUpWithEmailAndPassword({
    required String? fullName,
    required String? email,
    required String? password,
  });

  User? getCurrentUser();
}
