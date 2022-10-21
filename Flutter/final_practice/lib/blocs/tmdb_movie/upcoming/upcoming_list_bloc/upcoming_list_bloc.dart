import 'package:bloc/bloc.dart';

import '../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../../../repository/api/tmdb_movie_repository.dart';
import 'upcoming_list_event.dart';
import 'upcoming_list_state.dart';

class UpcomingListBloc extends Bloc<UpcomingListEvent, UpcomingListState> {
  final TMDBMovieRepository tmdbMovieRepository;

  var _page = 0;
  bool _isLoading = false;

  UpcomingListBloc(this.tmdbMovieRepository) : super(UpcomingListInitial()) {
    on<GetUpcomingListEvent>((event, emit) async {
      emit(UpcomingListLoadingState());
      try {
        final upcomingList =
            await tmdbMovieRepository.getFirstPageUpcomingList();
        if (upcomingList != null) {
          emit(UpcomingListSuccessState(upcomingList: upcomingList));
        } else {
          emit(UpcomingListFailState(message: 'Something Wrong! Try again.'));
        }
      } on Exception catch (_) {
        emit(UpcomingListFailState(message: 'Something Wrong! Try again.'));
      }
    });

    on<GetUpcomingListLoadMoreEvent>((event, emit) async {
      if (!_isLoading) {
        try {
          _page++;
          final responseList =
              await tmdbMovieRepository.getAllUpcomingList(_page);
          final listFilmResponse = <Results>[];
          if (responseList != null && responseList.results != null) {
            for (var i = 0; i < responseList.results!.length; i++) {
              listFilmResponse.add(responseList.results![i]);
              listFilmResponse[i].mediaType = 'movie';
            }
            emit(
              UpcomingListLoadMoreSuccessState(
                upcomingList: listFilmResponse,
              ),
            );
          } else {
            _page--;
            emit(
              UpcomingListFailState(
                message: 'Something Wrong! Try again.',
              ),
            );
          }
        } on Exception catch (_) {
          _page--;
          emit(
            UpcomingListFailState(
              message: 'Something Wrong! Try again.',
            ),
          );
        }
        _isLoading = false;
      }
    });
  }
}
