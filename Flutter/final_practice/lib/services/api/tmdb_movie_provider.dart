import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../../model/tmdb_movie/artists/artists_details.dart';
import '../../model/tmdb_movie/artists/artists_images_artists.dart';
import '../../model/tmdb_movie/artists/person.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/reviews_of_film.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../model/tmdb_movie/general_movie_tv_show_and_artsits/trailer_film.dart';
import '../../model/tmdb_movie/movie/genre.dart';
import '../../model/tmdb_movie/tv_show/tv_show.dart';
import '../tmdb_movie_service.dart';

class TMDBMovieProvider extends TMDBMovieService {
  @override
  Future<TvShow?> getTrendingList() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.TRENDING_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}',
        ),
      );
      if (response.statusCode == 200) {
        final listTrendingMovie = TvShow.fromJson(jsonDecode(response.body));
        return listTrendingMovie;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Trending fail: $error');
    }
  }

  @override
  Future<TMDBData?> getFirstPagePopularList() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.DISCOVER_TV_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY_DISCOVER}',
        ),
      );

      if (response.statusCode == 200) {
        final listPopularMovie =
            TMDBData.fromJson(jsonDecode(response.body))
              ..type = MediaType.tv;
        return listPopularMovie;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Popular fail: $error');
    }
  }

  @override
  Future<TMDBData?> getAllPopularFilm(int page) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.DISCOVER_TV_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY_DISCOVER_BEFORE}$page'
          '${PathConstant.OPTION_QUERY_DISCOVER_AFTER}',
        ),
      );
      if (response.statusCode == 200) {
        final listPopularMovie =
            TMDBData.fromJson(jsonDecode(response.body))
              ..type = MediaType.tv;
        return listPopularMovie;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Popular fail: $error');
    }
  }

  @override
  Future<TMDBData?> getFirstPageMostRecentList() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.RECENT_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY_PAGE_1}',
        ),
      );
      if (response.statusCode == 200) {
        final listMostRecentMovie =
            TMDBData.fromJson(jsonDecode(response.body))
              ..type = MediaType.tv;

        return listMostRecentMovie;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Most Recent fail: $error');
    }
  }

  @override
  Future<TMDBData?> getAllMostRecentList(int page) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.RECENT_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY_AND_PAGE}$page',
        ),
      );
      if (response.statusCode == 200) {
        final listPopularMovie =
            TMDBData.fromJson(jsonDecode(response.body))
              ..type = MediaType.tv;
        return listPopularMovie;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Most Recent fail: $error');
    }
  }

  @override
  Future<TMDBData?> getFirstPageUpcomingList() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.MOVIE_UPCOMING_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY_PAGE_1}',
        ),
      );
      if (response.statusCode == 200) {
        final movieUpcoming =
            TMDBData.fromJson(jsonDecode(response.body))
              ..type = MediaType.movie;
        return movieUpcoming;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Upcoming fail: $error');
    }
  }

  @override
  Future<TMDBData?> getAllUpcomingList(int page) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.MOVIE_UPCOMING_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY_AND_PAGE}$page',
        ),
      );
      if (response.statusCode == 200) {
        final listPopularMovie =
            TMDBData.fromJson(jsonDecode(response.body))
              ..type = MediaType.movie;
        return listPopularMovie;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Upcoming fail: $error');
    }
  }

  @override
  Future<Genre?> getAllGenreList() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.GENRE_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY}',
        ),
      );
      if (response.statusCode == 200) {
        final listGenre = Genre.fromJson(jsonDecode(response.body));
        return listGenre;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Genre fail: $error');
    }
  }

  @override
  Future<Person?> getAllArtists(int page) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.PERSON_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY_AND_PAGE}$page',
        ),
      );
      if (response.statusCode == 200) {
        final listArtists = Person.fromJson(jsonDecode(response.body));
        return listArtists;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Artists fail: $error');
    }
  }

  @override
  Future<TMDBData?> movieInByGenre(
      int genreId, int page) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.DISCOVER_MOVIE_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY_SEARCH_GENRE_BEFORE}$page'
          '${PathConstant.OPTION_QUERY_SEARCH_GENRE_PAGE}$genreId'
          '${PathConstant.OPTION_QUERY_SEARCH_GENRE_AFTER}',
        ),
      );
      if (response.statusCode == 200) {
        final listMovieInByGenre = TMDBData.fromJson(
          jsonDecode(response.body),
        );
        return listMovieInByGenre;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Movie In By Genre fail: $error');
    }
  }

  @override
  Future<TMDBData?> getSearchMulti(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}${PathConstant.SEARCH_MULTI_QUERY}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY_SEARCH_MULTI_BEFORE}$query'
          '${PathConstant.OPTION_QUERY_SEARCH_MULTI_AFTER}',
        ),
      );

      if (response.statusCode == 200) {
        final listMovieBySearch = TMDBData.fromJson(
          jsonDecode(response.body),
        );

        for (var i = 0; i < listMovieBySearch.results!.length; i++) {
          final listGenre = await getAllGenreList();
          // map = {id: name, id: name}
          if (listMovieBySearch.results![i].genreIds != null) {
            listGenre!.genres!.removeWhere(
              (genre) =>
                  !listMovieBySearch.results![i].genreIds!.contains(genre.id),
            );

            for (final genre in listGenre.genres!) {
              listMovieBySearch.results![i].genreNames!.add(genre.name!);
            }
          }
        }

        return listMovieBySearch;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Search Multi fail: $error');
    }
  }

  @override
  Future<FilmDetails?> getDetailsMovie(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}'
          '${PathConstant.DETAILS_MOVIE_QUERY_BEFORE}$id'
          '${PathConstant.DETAILS_QUERY_AFTER}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY}',
        ),
      );
      if (response.statusCode == 200) {
        final detailsMovie = FilmDetails.fromJson(
          jsonDecode(response.body),
        );
        return detailsMovie;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Details Movie fail: $error');
    }
  }

  @override
  Future<FilmDetails?> getDetailsTvShow(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}'
          '${PathConstant.DETAILS_TV_QUERY_BEFORE}$id'
          '${PathConstant.DETAILS_QUERY_AFTER}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY}',
        ),
      );
      if (response.statusCode == 200) {
        final detailsTvShow = FilmDetails.fromJson(
          jsonDecode(response.body),
        );
        return detailsTvShow;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Details TvShow fail: $error');
    }
  }

  @override
  Future<Person?> getCastOfMovie(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}'
          '${PathConstant.DETAILS_MOVIE_QUERY_BEFORE}$id'
          '${PathConstant.DETAILS_QUERY_CREDIT}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY}',
        ),
      );
      if (response.statusCode == 200) {
        final castOfMovie = Person.fromJson(
          jsonDecode(response.body),
        );
        return castOfMovie;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Cast Of Movie fail: $error');
    }
  }

  @override
  Future<Person?> getCastOfTvShow(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}'
          '${PathConstant.DETAILS_TV_QUERY_BEFORE}$id'
          '${PathConstant.DETAILS_QUERY_CREDIT}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY}',
        ),
      );
      if (response.statusCode == 200) {
        final castOfTvShow = Person.fromJson(
          jsonDecode(response.body),
        );
        return castOfTvShow;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Cast Of TvShow fail: $error');
    }
  }

  @override
  Future<ReviewsOfFilm?> getReviewsOfMovie(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}'
          '${PathConstant.DETAILS_MOVIE_QUERY_BEFORE}$id'
          '${PathConstant.DETAILS_QUERY_REVIEWS}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY}',
        ),
      );
      if (response.statusCode == 200) {
        final reviewsOfMovie = ReviewsOfFilm.fromJson(
          jsonDecode(response.body),
        );
        return reviewsOfMovie;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Reviews Of Film fail: $error');
    }
  }

  @override
  Future<ReviewsOfFilm?> getReviewsOfTvShow(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}'
          '${PathConstant.DETAILS_TV_QUERY_BEFORE}$id'
          '${PathConstant.DETAILS_QUERY_REVIEWS}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY}',
        ),
      );
      if (response.statusCode == 200) {
        final reviewsOfTvShow = ReviewsOfFilm.fromJson(
          jsonDecode(response.body),
        );
        return reviewsOfTvShow;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Reviews Of TvShow fail: $error');
    }
  }

  @override
  Future<TrailerFilm?> getTrailerOfMovie(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}'
          '${PathConstant.DETAILS_MOVIE_QUERY_BEFORE}$id'
          '${PathConstant.DETAILS_QUERY_VIDEO}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY}',
        ),
      );
      if (response.statusCode == 200) {
        final trailerOfMovie = TrailerFilm.fromJson(
          jsonDecode(response.body),
        );
        return trailerOfMovie;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Trailer Of Film fail: $error');
    }
  }

  @override
  Future<TrailerFilm?> getTrailerOfTvShow(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}'
          '${PathConstant.DETAILS_TV_QUERY_BEFORE}$id'
          '${PathConstant.DETAILS_QUERY_VIDEO}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY}',
        ),
      );
      if (response.statusCode == 200) {
        final trailerOfTvShow = TrailerFilm.fromJson(
          jsonDecode(response.body),
        );
        return trailerOfTvShow;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Trailer Of Film fail: $error');
    }
  }

  @override
  Future<ArtistsDetails?> getDetailsOfArtists(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}'
          '${PathConstant.DETAILS_ARTISTS_QUERY_BEFORE}$id'
          '${PathConstant.DETAILS_QUERY_AFTER}'
          '${PathConstant.API_KEY_MOVIE_DB}'
          '${PathConstant.OPTION_QUERY}',
        ),
      );
      if (response.statusCode == 200) {
        final detailsOfArtists = ArtistsDetails.fromJson(
          jsonDecode(response.body),
        );
        return detailsOfArtists;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Artists Details fail: $error');
    }
  }

  @override
  Future<ImagesOfArtists?> getImagesOfArtists(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${PathConstant.BASE_URL}'
          '${PathConstant.DETAILS_ARTISTS_QUERY_BEFORE}$id'
          '${PathConstant.DETAILS_QUERY_IMAGE}'
          '${PathConstant.API_KEY_MOVIE_DB}',
        ),
      );
      if (response.statusCode == 200) {
        final imagesOfArtists = ImagesOfArtists.fromJson(
          jsonDecode(response.body),
        );
        return imagesOfArtists;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print('Call API Artists Images fail: $error');
    }
  }
}
