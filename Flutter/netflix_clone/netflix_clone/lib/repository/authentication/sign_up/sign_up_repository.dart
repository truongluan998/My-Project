import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/providers/authentication_firebase_provider.dart';

class SignUpRepository {
  SignUpRepository({
    required AuthenticationFirebaseProvider authenticationFirebaseProvider,
  }) : _authenticationFirebaseProvider = authenticationFirebaseProvider;

  final AuthenticationFirebaseProvider _authenticationFirebaseProvider;

  Future<bool?> checkEmailExits(String emailAddress) async {
    final email = await _authenticationFirebaseProvider.checkIfEmailInUser(
      emailAddress: emailAddress,
    );
    return email;
  }

  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final user = await _authenticationFirebaseProvider
        .signUpWithEmailAndPassword(email: email, password: password);
    return user;
  }
}
