part of 'film_overview_bloc.dart';

@immutable
abstract class FilmOverviewState extends Equatable {
  const FilmOverviewState();
}

class FilmOverviewInitial extends FilmOverviewState {
  @override
  List<Object?> get props => [];
}

class FilmOverviewLoading extends FilmOverviewState {
  @override
  List<Object?> get props => [];
}

class FilmOverviewLoaded extends FilmOverviewState {
  const FilmOverviewLoaded(this.content);

  final Content content;

  @override
  List<Object?> get props => [content];
}

class FilmOverviewError extends FilmOverviewState {
  const FilmOverviewError(this.errorMessage);
  
  final String errorMessage;

  @override
  List<Object?> get props => [];
}
