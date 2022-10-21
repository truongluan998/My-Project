import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/final_practice_color.dart';
import 'artists/artists_screen.dart';
import 'discorver/discover_screen.dart';
import 'genres/genres_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String routeName = '/main';

  static Route route() => MaterialPageRoute(
        builder: (_) => const MainScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _pageIndex = DimensionConstant.PAGE_INDEX;

  late PageController _pageController;

  final List<Widget> _tabPages = const [
    DiscoverScreen(),
    GenresScreen(),
    ArtistsScreen(),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: _pageIndex);
    super.initState();
  }

  void _onTabTapped(int index) {
    _pageController.jumpToPage(
      index,
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: _onPageChanged,
          controller: _pageController,
          children: _tabPages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: DimensionConstant.ELEVATION_0,
          backgroundColor: FinalPracticeColor.whiteColor,
          currentIndex: _pageIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: DimensionConstant.PADDING_4),
                child: Icon(Icons.window_rounded),
              ),
              label: LabelConstant.DISCOVER,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: DimensionConstant.PADDING_4),
                child: Icon(Icons.donut_small_outlined),
              ),
              label: LabelConstant.GENRES,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: DimensionConstant.PADDING_4),
                child: Icon(Icons.person_pin),
              ),
              label: LabelConstant.ARTISTS,
            ),
          ],
        ),
      );
}
