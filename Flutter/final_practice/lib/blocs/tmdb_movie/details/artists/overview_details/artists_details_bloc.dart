import 'package:bloc/bloc.dart';

import '../../../../../repository/api/tmdb_movie_repository.dart';
import 'artists_details_event.dart';
import 'artists_details_state.dart';

class ArtistsDetailsBloc
    extends Bloc<ArtistsDetailsEvent, ArtistsDetailsState> {
  final TMDBMovieRepository tmdbMovieRepository;

  ArtistsDetailsBloc(this.tmdbMovieRepository)
      : super(ArtistsDetailsInitial()) {
    on<ShowDetailsOfArtistsEvent>((event, emit) async {
      emit(ShowArtistsDetailsLoadingState());
      try {
        final artistsDetails =
            await tmdbMovieRepository.getDetailsOfArtists(event.artistsId);
        if (artistsDetails != null) {
          emit(ShowArtistsDetailsSuccessState(artistsDetails: artistsDetails));
        } else {
          emit(
            ShowArtistsDetailsFailState(message: 'Something Wrong! Try again.'),
          );
        }
      } on Exception catch (_) {
        emit(
          ShowArtistsDetailsFailState(message: 'Something Wrong! Try again.'),
        );
      }
    });
  }
}
