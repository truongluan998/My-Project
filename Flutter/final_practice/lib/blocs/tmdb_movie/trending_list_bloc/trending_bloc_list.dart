import 'package:bloc/bloc.dart';
import '../../../repository/api/tmdb_movie_repository.dart';

import 'trending_event_list.dart';
import 'trending_state_list.dart';

class TrendingListBloc extends Bloc<TrendingListEvent, TrendingListState> {
  final TMDBMovieRepository tmdbMovieRepository;

  TrendingListBloc(this.tmdbMovieRepository)
      : super(TrendingListInitialState()) {
    on<GetTrendingListEvent>((event, emit) async {
      emit(TrendingListLoadingState());
      try {
        final trendingList = await tmdbMovieRepository.getTrendingList();
        if (trendingList != null) {
          emit(TrendingListSuccessState(trendingList: trendingList));
        } else {
          emit(TrendingListFailState(message: 'Something Wrong! Try again.'));
        }
      } on Exception catch (_) {
        emit(TrendingListFailState(message: 'Something Wrong! Try again.'));
      }
    });
  }
}
