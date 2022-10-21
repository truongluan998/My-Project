import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../services/firebase_database_service.dart';

class FirebaseDatabaseRepository {
  final FirebaseDatabaseService firebaseDatabaseService;

  FirebaseDatabaseRepository(this.firebaseDatabaseService);

  void addFavoriteItem({required FilmDetails film, required MediaType type}) =>
      firebaseDatabaseService.addFavoriteItem(film: film, type: type);

  void removeFavoriteItem(int id) =>
      firebaseDatabaseService.removeFavoriteItem(id);

  Future<bool> checkFavoriteFilm(int id) =>
      firebaseDatabaseService.checkFavoriteFilm(id);
}
