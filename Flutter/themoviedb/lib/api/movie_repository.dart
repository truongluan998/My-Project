
import 'package:themoviedb/model/movie_tmdb.dart';

abstract class MovieRepository{
  Future<MovieTMDB> getMovieList(var page);
}