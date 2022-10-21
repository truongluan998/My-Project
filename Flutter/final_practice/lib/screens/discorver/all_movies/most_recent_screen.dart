import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/tmdb_movie/recent/most_recent_bloc/most_recent_bloc.dart';
import '../../../blocs/tmdb_movie/recent/most_recent_bloc/most_recent_event.dart';
import '../../../blocs/tmdb_movie/recent/most_recent_bloc/most_recent_state.dart';
import '../../../constants/constants.dart';
import '../../../dependencies/app_dependencies.dart';
import '../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../../theme/final_practice_color.dart';
import '../../../widgets/general/check_internet_and_click_to_refresh.dart';
import '../../../widgets/general/custom_appbar.dart';
import '../../../widgets/general/gridview_load_more_film.dart';

class MostRecent extends StatefulWidget {
  const MostRecent({Key? key}) : super(key: key);

  static const String routeName = '/most_recent';

  static Route route() => MaterialPageRoute(
        builder: (_) => const MostRecent(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<MostRecent> createState() => _MostRecentState();
}

class _MostRecentState extends State<MostRecent> {
  late final MostRecentBloc _mostRecentBloc;
  final ScrollController _scrollController = ScrollController();
  static const double _endReachedThreshold = 0;
  late List<Results> resList = [];

  void _onScrollToLoadMoreMovie() {
    if (_scrollController.position.extentAfter == _endReachedThreshold) {
      _getDataFilmInAPI();
    }
  }

  void _getDataFilmInAPI() {
    _mostRecentBloc.add(GetMostRecentListLoadMoreEvent());
  }

  Future<void> _pullToRefresh() async {
    _getDataFilmInAPI();
  }

  @override
  void initState() {
    _mostRecentBloc = AppDependencies.injector.get<MostRecentBloc>();
    _getDataFilmInAPI();
    _scrollController.addListener(_onScrollToLoadMoreMovie);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(
          text: LabelConstant.ALL_MOVIE_MOST_RECENT,
          press: () {},
        ),
        body: RefreshIndicator(
          onRefresh: _pullToRefresh,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: FinalPracticeColor.backgroundScaffoldColor,
            padding: const EdgeInsets.only(
              left: DimensionConstant.PADDING_16,
              right: DimensionConstant.PADDING_16,
              bottom: DimensionConstant.PADDING_8,
            ),
            child: BlocBuilder(
              bloc: _mostRecentBloc,
              builder: (context, state) {
                if (state is MostRecentListLoadMoreSuccessState) {
                  resList.addAll(state.mostRecentList!);
                  return GridViewLoadMoreFilm(
                    scrollController: _scrollController,
                    resList: resList,
                  );
                }
                if (state is MostRecentState) {
                  return CheckInternetAndClickToRefresh(
                    press: _pullToRefresh,
                  );
                }
                return const Center(
                  child: Text(LabelConstant.LOADING),
                );
              },
            ),
          ),
        ),
      );
}
