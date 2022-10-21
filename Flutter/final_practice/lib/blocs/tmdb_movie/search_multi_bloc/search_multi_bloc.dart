import 'package:bloc/bloc.dart';
import '../../../repository/api/tmdb_movie_repository.dart';

import 'search_multi_event.dart';
import 'search_multi_state.dart';

class SearchMultiBloc extends Bloc<SearchMultiEvent, SearchMultiState> {
  final TMDBMovieRepository tmdbMovieRepository;

  SearchMultiBloc(this.tmdbMovieRepository) : super(SearchMultiInitial()) {
    on<GetDataFromSearchEvent>((event, emit) async {
      emit(SearchMultiLoadingState());
      try {
        final result = await tmdbMovieRepository.getSearchMulti(event.query);
        if (result != null) {
          emit(SearchMultiSuccessState(result: result));
        } else {
          emit(
            SearchMultiLFailState(message: 'Check Internet! And Try again.'),
          );
        }
      } on Exception catch (_) {
        emit(SearchMultiLFailState(message: 'Check Internet! And Try again.'));
      }
    });
    on<CloseSearchInAppBarEvent>((event, emit) {
      emit(CloseSearchInAppBarState());
    });
  }
}
