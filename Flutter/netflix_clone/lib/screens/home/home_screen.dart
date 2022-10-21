import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../assets.dart';
import '../../blocs/authentication_bloc/authentication/authentication_bloc.dart';
import '../../const/constants.dart';
import '../../data/data.dart';
import '../../theme/netflix_clone_color.dart';
import '../../utils/validators.dart';
import '../../widgets/general/app_circular_progress_indicator.dart';
import '../../widgets/home_screen/content_header.dart';
import '../../widgets/home_screen/list_film_horizontal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  static Route route() => MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late final AuthenticationBloc _authenticationBloc;

  double _scrollPosition = 0;

  _scrollListener() {
    _scrollPosition = _scrollController.position.pixels;
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        bloc: _authenticationBloc,
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const Center(
              child: AppCircularProgressIndicator(),
            );
          }
          if (state is AuthenticationFailure) {
            if (state.exception == ListExceptionAuthentication.logOutFail) {
              showToast(state.message);
            }
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            body: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverStack(
                  children: [
                    SliverToBoxAdapter(
                      child: ContentHeader(featuredContent: sintelContent),
                    ),
                    SliverAppBar(
                      expandedHeight: 110,
                      backgroundColor: _scrollPosition == 0
                          ? Colors.transparent
                          : Colors.black.withOpacity(0.8),
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: SafeArea(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        Assets.netflixLogo0,
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.search,
                                      color: NetflixCloneColor.textWhiteColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: IconButton(
                                      icon: const Icon(Icons.person),
                                      onPressed: () {
                                        _authenticationBloc.add(
                                          AuthenticationExited(),
                                        );
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/on_boarding',
                                          (route) => false,
                                        );
                                        showToast(
                                          'Logout account successfully',
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(60),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'TV Shows',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Movies',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Categories',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: DimensionConstant.PADDING_16,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: ListFilmHorizontal(
                      title: 'Previews',
                      contentList: previews,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListFilmHorizontal(
                    title: 'My List',
                    contentList: myList,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListFilmHorizontal(
                    title: 'Originals',
                    contentList: originals,
                  ),
                ),
              ],
            ),
          );
        },
      );
}
