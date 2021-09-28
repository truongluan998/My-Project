import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/api/movie_service.dart';
import 'package:themoviedb/bloc/movie/movie_bloc.dart';
import 'package:themoviedb/screen/movie/component/body.dart';

import '../../size_config.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  static String routeName = "/movie";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => MoviesBloc(movieService: MovieService()),
        child: Body(),
      ),
    );
  }

}





