part of 'film_overview_bloc.dart';

@immutable
abstract class FilmOverviewEvent extends Equatable {
  const FilmOverviewEvent();
}

class OpenOverviewFilm extends FilmOverviewEvent {
  const OpenOverviewFilm({required this.contentID, this.listContent});

  final DateTime? contentID;
  final List<Content>? listContent;

  @override
  List<Object?> get props => [contentID];

}