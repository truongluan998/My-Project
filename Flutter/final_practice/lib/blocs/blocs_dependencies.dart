import 'package:flutter_simple_dependency_injection/injector.dart';

import '../repository/api/tmdb_movie_repository.dart';
import '../repository/authentication/authentication_repository.dart';
import '../repository/firebase_database/firebase_database_repository.dart';
import '../utility/validators.dart';
import 'authentication/authentication/authentication_bloc.dart';
import 'connection/check_internet_connection_bloc.dart';
import 'tmdb_movie/artists/artists_list_load_more/artist_list_load_more_bloc.dart';
import 'tmdb_movie/details/artists/images/images_of_artists_bloc.dart';
import 'tmdb_movie/details/artists/overview_details/artists_details_bloc.dart';
import 'tmdb_movie/details/film/cast/cast_of_film_bloc.dart';
import 'tmdb_movie/details/film/favorite/save_favorite_film_to_firebase_bloc.dart';
import 'tmdb_movie/details/film/overview_details/film_details_bloc.dart';
import 'tmdb_movie/details/film/reviews/review_of_film_bloc.dart';
import 'tmdb_movie/details/film/trailer/trailer_of_film_bloc.dart';
import 'tmdb_movie/genre/genre_list_bloc/genre_list_bloc.dart';
import 'tmdb_movie/genre/movie_in_by_genre_bloc/movie_in_by_genre_bloc.dart';
import 'tmdb_movie/popular/popular_list_bloc/popular_list_bloc.dart';
import 'tmdb_movie/recent/most_recent_bloc/most_recent_bloc.dart';
import 'tmdb_movie/search_multi_bloc/search_multi_bloc.dart';
import 'tmdb_movie/trending_list_bloc/trending_bloc_list.dart';
import 'tmdb_movie/upcoming/upcoming_list_bloc/upcoming_list_bloc.dart';

class BlocsDependencies {
  static Injector initialise(Injector injector) {
    injector
        .map<CheckInternetConnectionBloc>(
          (injector) => CheckInternetConnectionBloc(),
        )
        .map<AuthenticationBloc>(
          (injector) => AuthenticationBloc(
            injector.get<AuthenticationRepository>(),
            injector.get<Validators>(),
          ),
        )
        .map<TrendingListBloc>(
          (injector) => TrendingListBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<PopularListBloc>(
          (injector) => PopularListBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<MostRecentBloc>(
          (injector) => MostRecentBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<UpcomingListBloc>(
          (injector) => UpcomingListBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<GenreListBloc>(
          (injector) => GenreListBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<ArtistListLoadMoreBloc>(
          (injector) =>
              ArtistListLoadMoreBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<MovieInByGenreBloc>(
          (injector) => MovieInByGenreBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<SearchMultiBloc>(
          (injector) => SearchMultiBloc(injector.get<TMDBMovieRepository>()),
          isSingleton: true,
        )
        .map<FilmDetailsBloc>(
          (injector) => FilmDetailsBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<CastOfFilmBloc>(
          (injector) => CastOfFilmBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<ReviewOfFilmBloc>(
          (injector) => ReviewOfFilmBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<TrailerOfFilmBloc>(
          (injector) => TrailerOfFilmBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<ArtistsDetailsBloc>(
          (injector) => ArtistsDetailsBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<ImagesOfArtistsBloc>(
          (injector) =>
              ImagesOfArtistsBloc(injector.get<TMDBMovieRepository>()),
        )
        .map<StoreFavoriteFilmToFirebaseBloc>(
          (injector) => StoreFavoriteFilmToFirebaseBloc(
            injector.get<FirebaseDatabaseRepository>(),
          ),
        );
    return injector;
  }
}
