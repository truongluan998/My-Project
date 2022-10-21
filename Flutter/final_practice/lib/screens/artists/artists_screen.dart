import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/tmdb_movie/artists/artists_list_load_more/artist_list_load_more_bloc.dart';
import '../../blocs/tmdb_movie/artists/artists_list_load_more/artist_list_load_more_event.dart';
import '../../blocs/tmdb_movie/artists/artists_list_load_more/artist_list_load_more_state.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../model/tmdb_movie/artists/person.dart';
import '../../theme/final_practice_color.dart';
import '../../widgets/general/check_internet_and_click_to_refresh.dart';
import '../../widgets/general/custom_appbar.dart';
import '../../widgets/general/gridview_load_more_artists.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({Key? key}) : super(key: key);

  static const String routeName = '/artists';

  static Route route() => MaterialPageRoute(
        builder: (_) => const ArtistsScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  late final ArtistListLoadMoreBloc _artistListLoadMoreBloc;

  final ScrollController _scrollController = ScrollController();
  static const double _endReachedThreshold = 0;
  late List<Results> resList = [];

  void _onScrollToLoadMoreMovie() {
    if (_scrollController.position.extentAfter == _endReachedThreshold) {
      _getDataArtistsInAPI();
    }
  }

  void _getDataArtistsInAPI() {
    _artistListLoadMoreBloc.add(GetArtistListLoadMoreEvent());
  }

  Future<void> _pullToRefresh() async {
    _getDataArtistsInAPI();
  }

  @override
  void initState() {
    _artistListLoadMoreBloc =
        AppDependencies.injector.get<ArtistListLoadMoreBloc>();
    _getDataArtistsInAPI();
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
          text: LabelConstant.ARTISTS,
          press: () {},
        ),
        body: RefreshIndicator(
          onRefresh: _pullToRefresh,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: FinalPracticeColor.backgroundScaffoldColor,
            child: BlocBuilder(
              bloc: _artistListLoadMoreBloc,
              builder: (context, state) {
                if (state is ArtistListLoadMoreSuccessState) {
                  resList.addAll(state.artistsList!);
                  return GridViewLoadMoreArtists(
                    scrollController: _scrollController,
                    resList: resList,
                  );
                }
                if (state is ArtistListLoadMoreFailState) {
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

