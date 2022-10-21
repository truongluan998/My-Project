import 'package:final_practice/services/firebase_database_service.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import '../services/authentication_service.dart';
import '../services/tmdb_movie_service.dart';
import 'api/tmdb_movie_repository.dart';
import 'authentication/authentication_repository.dart';
import 'firebase_database/firebase_database_repository.dart';

class RepositoryDependencies {
  static Injector initialise(Injector injector) {
    injector
        .map<AuthenticationRepository>(
          (i) =>
              AuthenticationRepository(injector.get<AuthenticationService>()),
        )
        .map<TMDBMovieRepository>(
          (i) => TMDBMovieRepository(injector.get<TMDBMovieService>()),
        )
        .map<FirebaseDatabaseRepository>(
          (i) => FirebaseDatabaseRepository(
              injector.get<FirebaseDatabaseService>()),
        );
    return injector;
  }
}
