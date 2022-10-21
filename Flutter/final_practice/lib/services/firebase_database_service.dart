import '../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';

import '../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';

abstract class FirebaseDatabaseService {
  void addFavoriteItem({required FilmDetails film, required MediaType type});

  void removeFavoriteItem(int id);

  Future<bool> checkFavoriteFilm(int id);
}