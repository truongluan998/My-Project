import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/model/day_in_week.dart';
import 'package:themoviedb/model/movie_tmdb.dart';

import 'component/body.dart';

class MovieDetailScreen extends StatelessWidget {

  static String routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final MovieDetailsArguments movieRouteArguments =
    ModalRoute.of(context)!.settings.arguments as MovieDetailsArguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Body(movieRouteArguments: movieRouteArguments,),
    );
  }
}

class MovieDetailsArguments {
  final Result result;
  MovieDetailsArguments({required this.result});
}
