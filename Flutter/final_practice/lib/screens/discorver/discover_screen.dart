import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/tmdb_movie/popular/popular_list_bloc/popular_list_bloc.dart';
import '../../blocs/tmdb_movie/popular/popular_list_bloc/popular_list_event.dart';
import '../../blocs/tmdb_movie/popular/popular_list_bloc/popular_list_state.dart';
import '../../blocs/tmdb_movie/recent/most_recent_bloc/most_recent_bloc.dart';
import '../../blocs/tmdb_movie/recent/most_recent_bloc/most_recent_event.dart';
import '../../blocs/tmdb_movie/recent/most_recent_bloc/most_recent_state.dart';
import '../../blocs/tmdb_movie/search_multi_bloc/search_multi_bloc.dart';
import '../../blocs/tmdb_movie/search_multi_bloc/search_multi_event.dart';
import '../../blocs/tmdb_movie/search_multi_bloc/search_multi_state.dart';
import '../../blocs/tmdb_movie/upcoming/upcoming_list_bloc/upcoming_list_bloc.dart';
import '../../blocs/tmdb_movie/upcoming/upcoming_list_bloc/upcoming_list_event.dart';
import '../../blocs/tmdb_movie/upcoming/upcoming_list_bloc/upcoming_list_state.dart';
import '../../config/size_config.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../theme/final_practice_color.dart';
import '../../utility/utility.dart';
import '../../widgets/discover/list_film_horizontal.dart';
import '../../widgets/general/app_circular_progress_indcator.dart';
import '../../widgets/general/custom_indicator_loading.dart';
import 'tab_search_multi/artists_screen.dart';
import 'tab_search_multi/genres_screen.dart';
import 'tab_search_multi/movies_screen.dart';
import 'tab_search_multi/tv_show_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  static const String routeName = '/discover';

  static Route route() => MaterialPageRoute(
        builder: (_) => const DiscoverScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with AutomaticKeepAliveClientMixin {
  late final Utils _utils;
  late final PopularListBloc _popularListBloc;
  late final UpcomingListBloc _upcomingListBloc;
  late final MostRecentBloc _mostRecentBloc;
  late final SearchMultiBloc _searchMultiBloc;

  bool _isSearching = false;

  static const List<Widget> _tabPages = [
    MoviesScreen(),
    TvShowScreen(),
    GenresScreen(),
    ArtistsSearchScreen(),
  ];

  void _getDataFilmInAPI() {
    _popularListBloc.add(GetPopularListEvent());
    _upcomingListBloc.add(GetUpcomingListEvent());
    _mostRecentBloc.add(GetMostRecentListEvent());
  }

  Future<void> _pullToRefresh() async {
    _getDataFilmInAPI();
  }

  @override
  void initState() {
    _utils = AppDependencies.injector.get<Utils>();
    _popularListBloc = AppDependencies.injector.get<PopularListBloc>();
    _upcomingListBloc = AppDependencies.injector.get<UpcomingListBloc>();
    _mostRecentBloc = AppDependencies.injector.get<MostRecentBloc>();
    _searchMultiBloc = AppDependencies.injector.get<SearchMultiBloc>();
    _getDataFilmInAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: _tabPages.length,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: !_isSearching,
            title: !_isSearching
                ? Text(
                    LabelConstant.DISCOVER,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                : const _SearchInAppBarOfDiscoverScreen(),
            actions: [
              Padding(
                padding: _isSearching
                    ? const EdgeInsets.only(top: DimensionConstant.PADDING_8)
                    : EdgeInsets.zero,
                child: !_isSearching
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _isSearching = !_isSearching;
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          size: DimensionConstant.HEIGHT_32,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          if (_isSearching == true) {
                            _searchMultiBloc.add(CloseSearchInAppBarEvent());
                          }
                          setState(() {
                            _isSearching = !_isSearching;
                          });
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.only(
                            right: DimensionConstant.PADDING_16,
                          ),
                        ),
                        child: const Text(
                          LabelConstant.CANCEL,
                          style: TextStyle(
                            fontSize: DimensionConstant.FONT_SIZE_17,
                          ),
                        ),
                      ),
              ),
            ],
          ),
          body: BlocBuilder(
            bloc: _searchMultiBloc,
            builder: (context, state) {
              if (state is SearchMultiSuccessState) {
                return Column(
                  children: [
                    SizedBox(
                      height: DimensionConstant.HEIGHT_40,
                      child: TabBar(
                        labelColor: Theme.of(context).primaryColor,
                        tabs: const [
                          Tab(text: LabelConstant.MOVIES),
                          Tab(text: LabelConstant.TV_SHOW),
                          Tab(text: LabelConstant.GENRES),
                          Tab(text: LabelConstant.ARTISTS),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: _tabPages,
                      ),
                    ),
                  ],
                );
              }
              if (state is SearchMultiLoadingState) {
                return const AppCircularProgressIndicator();
              }
              if (state is CloseSearchInAppBarState) {
                _bodyOfDiscoverScreen();
              }
              if (state is SearchMultiLFailState) {
                _utils.showToast(state.message);
              }
              return _bodyOfDiscoverScreen();
            },
          ),
        ),
      );

  RefreshIndicator _bodyOfDiscoverScreen() => RefreshIndicator(
        onRefresh: _pullToRefresh,
        child: Container(
          padding: const EdgeInsets.only(
            left: DimensionConstant.PADDING_16,
          ),
          width: double.infinity,
          height: double.infinity,
          color: FinalPracticeColor.backgroundScaffoldColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: DimensionConstant.PADDING_16,
              ),
              child: Column(
                children: [
                  BlocBuilder(
                    bloc: _popularListBloc,
                    builder: (context, state) {
                      if (state is PopularListLoadingState) {
                        return const CustomIndicatorLoading();
                      }
                      if (state is PopularListSuccessState) {
                        return ListFilmHorizontal(
                          title: LabelConstant.MOST_POPULAR,
                          data: state.popularList,
                          press: () =>
                              Navigator.pushNamed(context, '/most_popular'),
                        );
                      }
                      if (state is PopularListFailState) {
                        return SizedBox(
                          height: SizeConfig.screenHeight *
                              DimensionConstant.HEIGHT_0_DOT_8,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: DimensionConstant.PADDING_16,
                              ),
                              child: TextButton(
                                onPressed: _pullToRefresh,
                                child: Text(
                                  LabelConstant.CHECK_INTERNET,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: DimensionConstant.HEIGHT_16,
                  ),
                  BlocBuilder(
                    bloc: _mostRecentBloc,
                    builder: (context, state) {
                      if (state is MostRecentListLoadingState) {
                        return const CustomIndicatorLoading();
                      }
                      if (state is MostRecentListSuccessState) {
                        return ListFilmHorizontal(
                          title: LabelConstant.MOST_RECENT,
                          data: state.mostRecentList,
                          press: () =>
                              Navigator.pushNamed(context, '/most_recent'),
                        );
                      }
                      if (state is PopularListFailState) {}
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: DimensionConstant.HEIGHT_16,
                  ),
                  BlocBuilder(
                    bloc: _upcomingListBloc,
                    builder: (context, state) {
                      if (state is UpcomingListLoadingState) {
                        return const CustomIndicatorLoading();
                      }
                      if (state is UpcomingListSuccessState) {
                        return ListFilmHorizontal(
                          title: LabelConstant.COMING_SOON,
                          data: state.upcomingList,
                          press: () =>
                              Navigator.pushNamed(context, '/coming_soon'),
                        );
                      }
                      if (state is PopularListFailState) {
                        return const Center(child: Text('Internet Error'));
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}

class _SearchInAppBarOfDiscoverScreen extends StatefulWidget {
  const _SearchInAppBarOfDiscoverScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<_SearchInAppBarOfDiscoverScreen> createState() =>
      _SearchInAppBarOfDiscoverScreenState();
}

class _SearchInAppBarOfDiscoverScreenState
    extends State<_SearchInAppBarOfDiscoverScreen> {
  late final Utils _utils;
  late final TextEditingController _searchMulti;
  late final SearchMultiBloc _searchMultiBloc;
  Timer? _timerDelayToSearch;

  @override
  void initState() {
    _utils = AppDependencies.injector.get<Utils>();
    _searchMulti = TextEditingController();
    _searchMultiBloc = AppDependencies.injector.get<SearchMultiBloc>();
    super.initState();
  }

  void _timeRequireToSearch(String text) {
    if (_timerDelayToSearch != null) {
      _timerDelayToSearch!.cancel();
    }
    _timerDelayToSearch =
        Timer(const Duration(seconds: 1), () => _textRequireToSearch(text));
  }

  void _textRequireToSearch(String text) {
    if (text.length >= 2) {
      _searchMultiBloc.add(
        GetDataFromSearchEvent(query: _searchMulti.text),
      );
    } else {
      _utils.showToast('Please input 2 or more character');
    }
    if (text.isEmpty) {
      _searchMultiBloc.add(CloseSearchInAppBarEvent());
    }
  }

  @override
  void dispose() {
    _searchMulti.dispose();
    _timerDelayToSearch?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: DimensionConstant.PADDING_8),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                _searchMultiBloc.add(CloseSearchInAppBarEvent());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: Container(
                height: DimensionConstant.HEIGHT_40,
                decoration: BoxDecoration(
                  color: FinalPracticeColor.backgroundSearchColor,
                  borderRadius:
                      BorderRadius.circular(DimensionConstant.BORDER_RADIUS_6),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DimensionConstant.PADDING_8,
                      ),
                      child: Icon(
                        Icons.search,
                        size: DimensionConstant.SIZE_28,
                        color: Colors.black26,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchMulti,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black54),
                        onSubmitted: _timeRequireToSearch,
                        // onChanged: _timeRequireToSearch,
                        decoration: InputDecoration(
                          hintText: LabelConstant.SEARCH,
                          hintStyle:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: FinalPracticeColor.searchIconColor,
                                    fontSize: DimensionConstant.FONT_SIZE_17,
                                  ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
