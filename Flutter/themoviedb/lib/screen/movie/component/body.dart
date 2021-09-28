import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/bloc/movie/movie_bloc.dart';
import 'package:themoviedb/bloc/movie/movie_event.dart';
import 'package:themoviedb/bloc/movie/movie_state.dart';
import 'package:themoviedb/screen/component/search.dart';
import 'package:themoviedb/screen/component/section_header.dart';

import '../../../size_config.dart';
import 'catch_error.dart';
import 'girdview_list_movie.dart';
import 'header_movie.dart';
import 'loading.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _scrollController = ScrollController();
  static const double _endReachedThreshold = 300;

  void _onScroll() {
    final thresholdReached =
        _scrollController.position.extentAfter < _endReachedThreshold;
    if (thresholdReached) {
      _loadMovie();
    }
  }

  void _loadMovie() async {
    context.read<MoviesBloc>().add(MoviesEvent.fetchMovie);
  }

  @override
  void initState() {
    _loadMovie();
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenWidth(20),
          ),
          HeaderMovie(),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          Search(),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          SectionHeader(
            name: 'All Movies',
            property: 'Filters',
            icon: Icons.filter_list_sharp,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.03,
          ),
          Expanded(
            child: Container(child: BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state is MoviesLoaded) {
                  var result = state.movieTMDB;
                  return GridViewListMovie(
                      scrollController: _scrollController, listMovie: result);
                } else if (state is MoviesError) {
                  final error = state.error;
                  String message = '${error.message}\nTap to Retry';
                  return CatchError(
                    message: message,
                    onTap: () => _loadMovie(),
                  );
                }
                return Loading();
              },
            )),
          ),
        ],
      ),
    );
  }
}
