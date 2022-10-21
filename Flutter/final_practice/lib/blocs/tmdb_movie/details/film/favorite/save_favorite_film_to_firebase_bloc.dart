import 'package:bloc/bloc.dart';
import '../../../../../repository/firebase_database/firebase_database_repository.dart';
import 'save_favorite_film_to_firebase_event.dart';
import 'save_favorite_film_to_firebase_state.dart';

class StoreFavoriteFilmToFirebaseBloc extends Bloc<
    StoreFavoriteFilmToFirebaseEvent, SaveFavoriteFilmToFirebaseState> {
  final FirebaseDatabaseRepository firebaseDatabaseRepository;

  StoreFavoriteFilmToFirebaseBloc(this.firebaseDatabaseRepository)
      : super(SaveFavoriteFilmToFirebaseInitial()) {
    on<SaveToFavoriteListEvent>((event, emit) {
      firebaseDatabaseRepository.addFavoriteItem(
        film: event.results,
        type: event.mediaType,
      );
      emit(
        StoreFavoriteFilmSuccess(message: 'Save to favorite list successfully'),
      );
    });
    on<RemoveFromFavoriteListEvent>((event, emit) {
      firebaseDatabaseRepository.removeFavoriteItem(event.filmId);
      emit(
        StoreFavoriteFilmSuccess(
            message: 'Remove from favorite list successfully'),
      );
    });
    on<CheckFavoriteFilmEvent>((event, emit) async {
      try {
        final listFilmId =
            await firebaseDatabaseRepository.checkFavoriteFilm(event.filmId);
        if (listFilmId == true) {
          emit(FavoriteFilmState());
        } else {
          emit(NormalFilmState());
        }
      } on Exception catch (_) {}
    });
  }
}
