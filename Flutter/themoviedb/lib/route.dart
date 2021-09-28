import 'package:flutter/cupertino.dart';
import 'package:themoviedb/screen/details_movie/movie_detail_screen.dart';
import 'package:themoviedb/screen/movie/movie_screen.dart';

final Map<String, WidgetBuilder> routes = {
  MovieScreen.routeName : (context) => MovieScreen(),
  MovieDetailScreen.routeName : (context) => MovieDetailScreen(),
};