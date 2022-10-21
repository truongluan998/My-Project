import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../data/data.dart';
import '../../models/content_model.dart';

part 'film_overview_event.dart';

part 'film_overview_state.dart';

class FilmOverviewBloc extends Bloc<FilmOverviewEvent, FilmOverviewState> {
  FilmOverviewBloc(FilmOverviewInitial filmOverviewInitial)
      : super(filmOverviewInitial) {
    on<OpenOverviewFilm>((event, emit) {
      final Content film;
      emit(FilmOverviewLoading());
      try {
        if (event.listContent != null) {
          if (event.listContent!.first.id == previews.first.id) {
            film = previews.firstWhere((film) => film.id == event.contentID);
            emit(FilmOverviewLoaded(film));
          } else if (event.listContent!.first.id == myList.first.id) {
            film = myList.firstWhere((film) => film.id == event.contentID);
            emit(FilmOverviewLoaded(film));
          } else if (event.listContent!.first.id == originals.first.id) {
            film = originals.firstWhere((film) => film.id == event.contentID);
            emit(FilmOverviewLoaded(film));
          }
        } else {
          film = sintelContent;
          emit(FilmOverviewLoaded(film));
        }
      } on Exception catch (_) {
        emit(const FilmOverviewError('Load Film Fail'));
      }
    });
  }
}
