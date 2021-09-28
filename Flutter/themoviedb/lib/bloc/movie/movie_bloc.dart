import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/api/exception.dart';
import 'package:themoviedb/api/movie_service.dart';
import 'package:themoviedb/bloc/movie/movie_event.dart';
import 'package:themoviedb/bloc/movie/movie_state.dart';
import 'package:themoviedb/model/movie_tmdb.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc({required this.movieService}) : super(MoviesInitState());

  final MovieService movieService;
  late MovieTMDB movieTMDB;
  var page = 0;
  bool isLoading = false;
  List<Result> movieTMDBList = [];

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    switch (event) {
      case MoviesEvent.fetchMovie:
        // yield MoviesLoading();
        if (!isLoading) {
          isLoading = true;
          try {
            page++;
            movieTMDB = await movieService.getMovieList(page);
            List<Result> listResponse = [];
            if(movieTMDB.results.length == 0) {
              page--;
              yield MoviesError(error: 'Fail to Fetch Movie');
            } else {
              for(int i = 0; i < movieTMDB.results.length; i++) {
                listResponse.add(movieTMDB.results[i]);
              }
              movieTMDBList.addAll(listResponse);
              yield MoviesLoaded(movieTMDB: movieTMDBList);
            }
          } on SocketException {
            yield MoviesError(error: NoInternetException('No Internet'));
          } on HttpException {
            yield MoviesError(
                error: NoServiceFoundException('No Service Found'));
          } on FormatException {
            yield MoviesError(
                error: InvalidFormatException('Invalid Response format'));
          } catch (e) {
            page--;
            yield MoviesError(error: UnknownException('$e'));
          }
          isLoading = false;
          break;
        }
    }
  }
}
