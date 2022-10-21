import 'package:bloc/bloc.dart';

import '../../../../model/tmdb_movie/artists/person.dart';
import '../../../../repository/api/tmdb_movie_repository.dart';
import 'artist_list_load_more_event.dart';
import 'artist_list_load_more_state.dart';

class ArtistListLoadMoreBloc
    extends Bloc<ArtistListLoadMoreEvent, ArtistListLoadMoreState> {
  final TMDBMovieRepository tmdbMovieRepository;

  var _page = 0;
  bool _isLoading = false;

  ArtistListLoadMoreBloc(this.tmdbMovieRepository)
      : super(ArtistListLoadMoreInitial()) {
    on<GetArtistListLoadMoreEvent>((event, emit) async {
      if (!_isLoading) {
        try {
          _page++;
          final responseList = await tmdbMovieRepository.getAllArtists(_page);
          final listFilmResponse = <Results>[];
          if (responseList != null && responseList.results != null) {
            for (var i = 0; i < responseList.results!.length; i++) {
              listFilmResponse.add(responseList.results![i]);
            }
            emit(
              ArtistListLoadMoreSuccessState(
                artistsList: listFilmResponse,
              ),
            );
          } else {
            _page--;
            emit(
              ArtistListLoadMoreFailState(
                message: 'Something Wrong! Try again.',
              ),
            );
          }
        } on Exception catch (_) {
          _page--;
          emit(
            ArtistListLoadMoreFailState(message: 'Something Wrong! Try again.'),
          );
        }
        _isLoading = false;
      }
    });
  }
}
