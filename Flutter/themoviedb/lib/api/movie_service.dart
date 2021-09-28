
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:themoviedb/model/movie_tmdb.dart';
import 'package:themoviedb/resource/strings.dart';

import 'movie_repository.dart';

class MovieService implements MovieRepository {

  @override
  Future<MovieTMDB> getMovieList(var page) async {
    Response response = await http.get(Uri.parse(
        '${AppStrings.baseUrl}$page'));
    MovieTMDB movies = movieTMDBFromJson(response.body);
    return movies;
  }

}