import 'package:bloc/bloc.dart';
import '../../../../dependencies/app_dependencies.dart';
import '../../../../repository/api/tmdb_movie_repository.dart';

import 'genre_list_event.dart';
import 'genre_list_state.dart';

class GenreListBloc extends Bloc<GenreListEvent, GenreListState> {
  final TMDBMovieRepository tmdbMovieRepository;

  GenreListBloc(this.tmdbMovieRepository) : super(GenreListInitial()) {
    on<GetGenreListEvent>((event, emit) async {
      emit(GenreListLoadingState());
      try {
        final genreList = await tmdbMovieRepository.getAllGenreList();
        if (genreList != null) {
          emit(GenreListSuccessState(genreList: genreList));
        } else {
          emit(GenreListFailState(message: 'Fail'));
        }
      } on Exception catch (_) {
        emit(GenreListFailState(message: 'Fail'));
      }
    });
  }
}
