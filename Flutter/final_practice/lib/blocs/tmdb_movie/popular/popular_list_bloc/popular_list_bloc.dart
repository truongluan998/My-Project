import 'package:bloc/bloc.dart';

import '../../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../../../repository/api/tmdb_movie_repository.dart';
import 'popular_list_event.dart';
import 'popular_list_state.dart';

class PopularListBloc extends Bloc<PopularListEvent, PopularListState> {
  final TMDBMovieRepository tmdbMovieRepository;

  var _page = 0;
  bool _isLoading = false;

  PopularListBloc(this.tmdbMovieRepository) : super(PopularListInitial()) {
    on<GetPopularListEvent>((event, emit) async {
      emit(PopularListLoadingState());
      try {
        final popularList = await tmdbMovieRepository.getFirstPagePopularList();
        if (popularList != null) {
          emit(PopularListSuccessState(popularList: popularList));
        } else {
          emit(PopularListFailState(message: 'Fail'));
        }
      } on Exception catch (_) {
        emit(PopularListFailState(message: 'Fail'));
      }
    });

    on<GetPopularListLoadMoreEvent>((event, emit) async {
      if (!_isLoading) {
        try {
          _page++;
          final responseList =
              await tmdbMovieRepository.getAllPopularFilm(_page);
          final listFilmResponse = <Results>[];
          if (responseList != null && responseList.results != null) {
            for (var i = 0; i < responseList.results!.length; i++) {
              listFilmResponse.add(responseList.results![i]);
              listFilmResponse[i].mediaType = 'tv';
            }
            emit(
              PopularListLoadMoreSuccessState(
                popularList: listFilmResponse,
              ),
            );
          } else {
            _page--;
            emit(
              PopularListFailState(
                message: 'Something Wrong! Try again.',
              ),
            );
          }
        } on Exception catch (_) {
          _page--;
          emit(
            PopularListFailState(
              message: 'Something Wrong! Try again.',
            ),
          );
        }
        _isLoading = false;
      }
    });
  }
}
