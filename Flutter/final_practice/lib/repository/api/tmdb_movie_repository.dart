import '../../model/tmdb_movie/artists/artists_details.dart';
import '../../model/tmdb_movie/artists/artists_images_artists.dart';
import '../../model/tmdb_movie/artists/person.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/reviews_of_film.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/trailer_film.dart';
import '../../model/tmdb_movie/movie/genre.dart';
import '../../model/tmdb_movie/tv_show/tv_show.dart';
import '../../services/tmdb_movie_service.dart';

class TMDBMovieRepository {
  final TMDBMovieService tmdbMovieService;

  TMDBMovieRepository(this.tmdbMovieService);

  Future<TvShow?> getTrendingList() => tmdbMovieService.getTrendingList();

  Future<TMDBData?> getFirstPagePopularList() =>
      tmdbMovieService.getFirstPagePopularList();

  Future<TMDBData?> getAllPopularFilm(int page) =>
      tmdbMovieService.getAllPopularFilm(page);

  Future<TMDBData?> getFirstPageMostRecentList() =>
      tmdbMovieService.getFirstPageMostRecentList();

  Future<TMDBData?> getAllMostRecentList(int page) =>
      tmdbMovieService.getAllMostRecentList(page);

  Future<TMDBData?> getFirstPageUpcomingList() =>
      tmdbMovieService.getFirstPageUpcomingList();

  Future<TMDBData?> getAllUpcomingList(int page) =>
      tmdbMovieService.getAllUpcomingList(page);

  Future<Genre?> getAllGenreList() => tmdbMovieService.getAllGenreList();

  Future<Person?> getAllArtists(int page) =>
      tmdbMovieService.getAllArtists(page);

  Future<TMDBData?> movieInByGenre(int genreId, int page) =>
      tmdbMovieService.movieInByGenre(genreId, page);

  Future<TMDBData?> getSearchMulti(String query) =>
      tmdbMovieService.getSearchMulti(query);

  Future<FilmDetails?> getDetailsMovie(int id) =>
      tmdbMovieService.getDetailsMovie(id);

  Future<FilmDetails?> getDetailsTvShow(int id) =>
      tmdbMovieService.getDetailsTvShow(id);

  Future<Person?> getCastOfMovie(int id) => tmdbMovieService.getCastOfMovie(id);

  Future<Person?> getCastOfTvShow(int id) =>
      tmdbMovieService.getCastOfTvShow(id);

  Future<ReviewsOfFilm?> getReviewsOfMovie(int id) =>
      tmdbMovieService.getReviewsOfMovie(id);

  Future<ReviewsOfFilm?> getReviewsOfTvShow(int id) =>
      tmdbMovieService.getReviewsOfTvShow(id);

  Future<TrailerFilm?> getTrailerOfMovie(int id) =>
      tmdbMovieService.getTrailerOfMovie(id);

  Future<TrailerFilm?> getTrailerOfTvShow(int id) =>
      tmdbMovieService.getTrailerOfTvShow(id);

  Future<ArtistsDetails?> getDetailsOfArtists(int id) =>
      tmdbMovieService.getDetailsOfArtists(id);

  Future<ImagesOfArtists?> getImagesOfArtists(int id) =>
      tmdbMovieService.getImagesOfArtists(id);
}
