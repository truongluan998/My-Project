import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import 'api/tmdb_movie_provider.dart';
import 'authentication_service.dart';
import 'firebase_database/firebase_database_provider.dart';
import 'firebase_database_service.dart';
import 'provider_authen/authencation_firebase_provider.dart';
import 'tmdb_movie_service.dart';

class ServicesDependencies {
  static Injector initialise(Injector injector) {
    injector
        .map<FirebaseAuth>((i) => FirebaseAuth.instance)
        .map<AuthenticationService>(
          (i) => AuthenticationFirebaseProvider(injector.get<FirebaseAuth>()),
        )
        .map<FirebaseDatabaseService>(
          (i) =>
              FirebaseDatabaseProvider(injector.get<AuthenticationService>()),
        )
        .map<TMDBMovieService>((i) => TMDBMovieProvider());
    return injector;
  }
}
