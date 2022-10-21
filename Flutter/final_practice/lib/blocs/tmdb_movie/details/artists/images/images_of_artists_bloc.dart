import 'package:bloc/bloc.dart';
import '../../../../../repository/api/tmdb_movie_repository.dart';
import 'images_of_artists_event.dart';
import 'images_of_artists_state.dart';

class ImagesOfArtistsBloc
    extends Bloc<ImagesOfArtistsEvent, ImagesOfArtistsState> {
  final TMDBMovieRepository tmdbMovieRepository;

  ImagesOfArtistsBloc(this.tmdbMovieRepository)
      : super(ImagesOfArtistsInitial()) {
    on<GetImagesOfArtistsEvent>((event, emit) async {
      emit(ShowImagesOfArtistsLoadingState());
      try {
        final imagesOfArtists =
            await tmdbMovieRepository.getImagesOfArtists(event.artistsId);
        if (imagesOfArtists != null) {
          emit(
            ShowImagesOfArtistsSuccessState(
              imagesOfArtists: imagesOfArtists,
            ),
          );
        } else {
          emit(
            ShowImagesOfArtistsFailState(
              message: 'Something Wrong! Try again.',
            ),
          );
        }
      } on Exception catch (_) {
        emit(
          ShowImagesOfArtistsFailState(message: 'Something Wrong! Try again.'),
        );
      }
    });
  }
}
