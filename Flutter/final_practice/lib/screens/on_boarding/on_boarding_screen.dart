import 'package:flutter/material.dart';

import '../../blocs/tmdb_movie/trending_list_bloc/trending_bloc_list.dart';
import '../../blocs/tmdb_movie/trending_list_bloc/trending_event_list.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../widgets/on_boarding/explore_button_on_boarding.dart';
import '../../widgets/on_boarding/explore_dot_indicator.dart';
import '../../widgets/on_boarding/on_boarding_content.dart';
import 'first_on_boarding_screen.dart';
import 'second_on_boarding_screen.dart';
import 'third_on_boarding_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  static const String routeName = '/on_boarding';

  static Route route() => MaterialPageRoute(
        builder: (_) => const OnBoardingScreen(),
        settings: const RouteSettings(name: routeName),
      );

  static const List<Tab> tabs = <Tab>[
    Tab(text: LabelConstant.FIRST_ON_BOARDING),
    Tab(text: LabelConstant.SECOND_ON_BOARDING),
    Tab(text: LabelConstant.THIRD_ON_BOARDING),
  ];

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: OnBoardingScreen.tabs.length,
        child: Builder(
          builder: (context) {
            final _tabController = DefaultTabController.of(context)!;
            _tabController.addListener(
              () {
                if (!_tabController.indexIsChanging) {
                  setState(() {});
                }
              },
            );
            return Scaffold(
              extendBodyBehindAppBar: true,
              body: Stack(
                children: [
                  const TabBarView(
                    children: [
                      FirstOnBoardingScreen(),
                      SecondOnBoardingScreen(),
                      ThirdOnBoardingScreen()
                    ],
                  ),
                  const OnBoardingContent(),
                  Positioned(
                    bottom: DimensionConstant.POSITIONED_48,
                    left: DimensionConstant.POSITIONED_48,
                    right: DimensionConstant.POSITIONED_48,
                    child: Column(
                      children: [
                        const ExploreButtonOnBoarding(),
                        const SizedBox(height: DimensionConstant.HEIGHT_24),
                        ExploreDotIndicator(tabController: _tabController)
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
}
