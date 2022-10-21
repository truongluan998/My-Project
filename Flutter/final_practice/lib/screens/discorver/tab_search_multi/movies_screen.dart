import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/tmdb_movie/search_multi_bloc/search_multi_bloc.dart';
import '../../../blocs/tmdb_movie/search_multi_bloc/search_multi_state.dart';
import '../../../constants/constants.dart';
import '../../../dependencies/app_dependencies.dart';
import '../../../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';
import '../../../theme/final_practice_color.dart';
import '../../../utility/utility.dart';
import '../../../widgets/general/custom_listview_item_in_search.dart';
import '../../../widgets/general/text_notification.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen>
    with AutomaticKeepAliveClientMixin {
  late final SearchMultiBloc _searchMultiBloc;
  late final Utils _utils;

  final List<Results> _listMovie = [];

  @override
  void initState() {
    _searchMultiBloc = AppDependencies.injector.get<SearchMultiBloc>();
    _utils = AppDependencies.injector.get<Utils>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder(
          bloc: _searchMultiBloc,
          builder: (context, state) {
            if (state is SearchMultiLoadingState) {
              return const TextNotification(
                text: LabelConstant.LOADING,
              );
            }
            if (state is SearchMultiSuccessState) {
              _utils.filterResultsWhenSearch(state.result, _listMovie, 'movie');
              return _listMovie.isEmpty
                  ? const Center(
                      child: Text(LabelConstant.NO_DATA),
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: FinalPracticeColor.backgroundScaffoldColor,
                      child: CustomListViewItemInSearch(listResult: _listMovie),
                    );
            }
            if (state is SearchMultiLFailState) {
              return const TextNotification(
                text: LabelConstant.SEARCH_FAIL,
              );
            }
            return const Center(
              child: Text(LabelConstant.NO_DATA),
            );
          },
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
