import 'package:firebase_database/firebase_database.dart';

import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../authentication_service.dart';
import '../firebase_database_service.dart';

class FirebaseDatabaseProvider extends FirebaseDatabaseService {
  final AuthenticationService authenticationService;

  FirebaseDatabaseProvider(this.authenticationService);

  @override
  void addFavoriteItem({required FilmDetails film, required MediaType type}) {
    FirebaseDatabase.instance
        .ref('${authenticationService.getCurrentUser()!.uid}/${film.id}')
        .set({
      'id': film.id,
      'username': authenticationService.getCurrentUser()!.email!.split('@')[0],
      'fullName': authenticationService.getCurrentUser()!.displayName,
      'mediaType': type.toString().split('.')[1],
      'mediaName': film.title,
      'imagePath': film.posterPath,
      'dateTimeCreated': DateTime.now().toString(),
    });
  }

  @override
  void removeFavoriteItem(int id) {
    FirebaseDatabase.instance
        .ref('${authenticationService.getCurrentUser()!.uid}/$id')
        .remove();
  }

  @override
  Future<bool> checkFavoriteFilm(int id) async {
    final reference = FirebaseDatabase.instance
        .ref(authenticationService.getCurrentUser()!.uid);
    final event = await reference.get();
    final listFavorite = <int>[];
    for (final child in event.children) {
      listFavorite.add(int.parse(child.key!));
    }
    if (listFavorite.contains(id)) {
      return true;
    } else {
      return false;
    }
  }
}
