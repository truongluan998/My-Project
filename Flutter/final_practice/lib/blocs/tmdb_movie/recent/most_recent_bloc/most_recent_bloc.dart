import 'package:bloc/bloc.dart';

import '../../../../dependencies/app_dependencies.dart';
import '../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../../../repository/api/tmdb_movie_repository.dart';
import 'most_recent_event.dart';
import 'most_recent_state.dart';

class MostRecentBloc extends Bloc<MostRecentEvent, MostRecentState> {
  final TMDBMovieRepository tmdbMovieRepository;

  var _page = 0;
  bool _isLoading = false;

  MostRecentBloc(this.tmdbMovieRepository) : super(MostRecentInitial()) {
    on<GetMostRecentListEvent>((event, emit) async {
      emit(MostRecentListLoadingState());
      try {
        final mostRecentList =
            await tmdbMovieRepository.getFirstPageMostRecentList();
        if (mostRecentList != null) {
          emit(MostRecentListSuccessState(mostRecentList: mostRecentList));
        } else {
          emit(MostRecentListFailState(message: 'Something Wrong! Try again.'));
        }
      } on Exception catch (_) {
        emit(MostRecentListFailState(message: 'Something Wrong! Try again.'));
      }
    });
    on<GetMostRecentListLoadMoreEvent>((event, emit) async {
      if (!_isLoading) {
        try {
          _page++;
          final responseList =
              await tmdbMovieRepository.getAllMostRecentList(_page);
          final listFilmResponse = <Results>[];
          if (responseList != null && responseList.results != null) {
            for (var i = 0; i < responseList.results!.length; i++) {
              listFilmResponse.add(responseList.results![i]);
              listFilmResponse[i].mediaType = 'tv';
            }
            emit(
              MostRecentListLoadMoreSuccessState(
                mostRecentList: listFilmResponse,
              ),
            );
          } else {
            _page--;
            emit(
              MostRecentListFailState(
                message: 'Something Wrong! Try again.',
              ),
            );
          }
        } on Exception catch (_) {
          _page--;
          emit(
            MostRecentListFailState(
              message: 'Something Wrong! Try again.',
            ),
          );
        }
        _isLoading = false;
      }
    });
  }
}
