import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/tmdb_movie/trending_list_bloc/trending_bloc_list.dart';
import '../../blocs/tmdb_movie/trending_list_bloc/trending_event_list.dart';
import '../../blocs/tmdb_movie/trending_list_bloc/trending_state_list.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../utility/utility.dart';
import '../../widgets/general/default_shimmer.dart';
import '../../widgets/on_boarding/background_on_boading_screen_fail.dart';
import '../../widgets/on_boarding/background_on_boarding_screen.dart';

class FirstOnBoardingScreen extends StatefulWidget {
  const FirstOnBoardingScreen({Key? key}) : super(key: key);

  static const String routeName = '/first_on_boarding';

  static Route route() => MaterialPageRoute(
        builder: (_) => const FirstOnBoardingScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<FirstOnBoardingScreen> createState() => _FirstOnBoardingScreenState();
}

class _FirstOnBoardingScreenState extends State<FirstOnBoardingScreen>
    with AutomaticKeepAliveClientMixin {
  late final Utils _utils;
  late final TrendingListBloc _trendingListBloc;

  @override
  void initState() {
    _utils = AppDependencies.injector.get<Utils>();
    _trendingListBloc = AppDependencies.injector.get<TrendingListBloc>();
    _trendingListBloc.add(GetTrendingListEvent());
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    dynamic pathImage;
    return Scaffold(
      body: BlocBuilder(
        bloc: _trendingListBloc,
        builder: (context, state) {
          if (state is TrendingListLoadingState) {
            return DefaultShimmer(
              widget: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
              ),
            );
          }
          if (state is TrendingListSuccessState) {
            pathImage = state
                .trendingList!
                .results![_utils.randomItemInResultList(
              state.trendingList!.results!.length,
            )]
                .posterPath;
            return BackGroundOnBoardingScreen(pathImage: pathImage);
          }
          if (state is TrendingListFailState) {
            return const BackGroundOnBoardingScreenFail(
              assetImage: PathConstant.IMAGE_DEFAULT_WHEN_LOAD_IMAGE_ERROR_1,
            );
          }
          return Container();
        },
      ),
    );
  }
}
