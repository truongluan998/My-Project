import '../model/tmdb_movie/artists/artists_details.dart';
import '../model/tmdb_movie/artists/artists_images_artists.dart';
import '../model/tmdb_movie/artists/person.dart';
import '../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';
import '../model/tmdb_movie/general_movie_tv_show_and_artsits/reviews_of_film.dart';
import '../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../model/tmdb_movie/general_movie_tv_show_and_artsits/trailer_film.dart';
import '../model/tmdb_movie/movie/genre.dart';
import '../model/tmdb_movie/tv_show/tv_show.dart';

abstract class TMDBMovieService {
  Future<TvShow?> getTrendingList();

  Future<TMDBData?> getFirstPagePopularList();

  Future<TMDBData?> getAllPopularFilm(int page);

  Future<TMDBData?> getFirstPageMostRecentList();

  Future<TMDBData?> getAllMostRecentList(int page);

  Future<TMDBData?> getFirstPageUpcomingList();

  Future<TMDBData?> getAllUpcomingList(int page);

  Future<Genre?> getAllGenreList();

  Future<Person?> getAllArtists(int page);

  Future<TMDBData?> movieInByGenre(int genreId, int page);

  Future<TMDBData?> getSearchMulti(String query);

  Future<FilmDetails?> getDetailsMovie(int id);

  Future<FilmDetails?> getDetailsTvShow(int id);

  Future<Person?> getCastOfMovie(int id);

  Future<Person?> getCastOfTvShow(int id);

  Future<ReviewsOfFilm?> getReviewsOfMovie(int id);

  Future<ReviewsOfFilm?> getReviewsOfTvShow(int id);

  Future<TrailerFilm?> getTrailerOfMovie(int id);

  Future<TrailerFilm?> getTrailerOfTvShow(int id);

  Future<ArtistsDetails?> getDetailsOfArtists(int id);

  Future<ImagesOfArtists?> getImagesOfArtists(int id);
}
