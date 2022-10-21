import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/tmdb_movie/details/artists/images/images_of_artists_bloc.dart';
import '../../blocs/tmdb_movie/details/artists/images/images_of_artists_event.dart';
import '../../blocs/tmdb_movie/details/artists/images/images_of_artists_state.dart';
import '../../blocs/tmdb_movie/details/artists/overview_details/artists_details_bloc.dart';
import '../../blocs/tmdb_movie/details/artists/overview_details/artists_details_event.dart';
import '../../blocs/tmdb_movie/details/artists/overview_details/artists_details_state.dart';
import '../../config/size_config.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../widgets/artists_details/basic_info_of_artists.dart';
import '../../widgets/artists_details/custom_opacity_of_image.dart';
import '../../widgets/artists_details/custom_overview_image.dart';
import '../../widgets/artists_details/custom_photo_albums.dart';
import '../../widgets/film_details/background_image.dart';
import '../../widgets/general/appbar_details_screen.dart';
import '../../widgets/general/tab_more_information_of_film.dart';
import '../../widgets/general/text_notification.dart';
import 'artists/tab_of_details_of_artists/more_screen.dart';
import 'artists/tab_of_details_of_artists/movies_screen.dart';
import 'artists/tab_of_details_of_artists/summary_screen.dart';

class ArtistsDetailScreen extends StatefulWidget {
  const ArtistsDetailScreen({Key? key}) : super(key: key);

  static const String routeName = '/artists_details';

  static Route route() => MaterialPageRoute(
        builder: (_) => const ArtistsDetailScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  _ArtistsDetailScreenState createState() => _ArtistsDetailScreenState();
}

class _ArtistsDetailScreenState extends State<ArtistsDetailScreen>
    with AfterLayoutMixin {
  late final ArtistsDetailsBloc _artistsDetailsBloc;
  late final ImagesOfArtistsBloc _imagesOfArtistsBloc;
  late final int artistsId;

  @override
  void initState() {
    _artistsDetailsBloc = AppDependencies.injector.get<ArtistsDetailsBloc>();
    _imagesOfArtistsBloc = AppDependencies.injector.get<ImagesOfArtistsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map;
    artistsId = arguments['artists_id'];

    final _tabPages = <Widget>[
      SummaryScreen(artistsId: artistsId),
      const MoviesScreen(),
      const MoreScreen(),
    ];

    return DefaultTabController(
      length: _tabPages.length,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppBarDetailsScreen(),
        body: BlocBuilder(
          bloc: _artistsDetailsBloc,
          builder: (context, state) {
            if (state is ShowArtistsDetailsLoadingState) {
              return const TextNotification(
                text: LabelConstant.LOADING,
              );
            }
            if (state is ShowArtistsDetailsSuccessState) {
              return SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          BackgroundImage(
                            imagePath: state.artistsDetails!.profilePath ?? '',
                            heightOfImage: SizeConfig.screenHeight *
                                DimensionConstant.HEIGHT_0_DOT_45,
                          ),
                          const CustomOpacityOfImage(),
                          BasicInfoOfArtists(
                            artistsDetails: state.artistsDetails!,
                          )
                        ],
                      ),
                      BlocBuilder(
                        bloc: _imagesOfArtistsBloc,
                        builder: (context, state) => Container(
                          child: (state is ShowImagesOfArtistsSuccessState)
                              ? state.imagesOfArtists!.profiles!.isNotEmpty
                                  ? SizedBox(
                                      width: SizeConfig.screenWidth,
                                      height: SizeConfig.screenHeight *
                                          DimensionConstant.HEIGHT_0_DOT_15,
                                      child: Row(
                                        children: [
                                          CustomPhotoAlbums(
                                            imagesOfArtists:
                                                state.imagesOfArtists!,
                                            artistsId: artistsId,
                                          ),
                                          CustomOverviewImage(
                                            imagesOfArtists:
                                                state.imagesOfArtists!,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container()
                              : (state is ShowImagesOfArtistsLoadingState)
                                  ? const TextNotification(
                                      text: LabelConstant.LOADING,
                                    )
                                  : (state is ShowImagesOfArtistsFailState)
                                      ? TextNotification(
                                          text: state.message,
                                        )
                                      : Container(),
                        ),
                      ),
                      TabMoreInformation(
                        tabPages: _tabPages,
                        heightOfTab: SizeConfig.screenHeight *
                            DimensionConstant.HEIGHT_0_DOT_40,
                        textTabOne: LabelConstant.SUMMARY,
                        textTabTwo: LabelConstant.MOVIES,
                        textTabThree: LabelConstant.MORE,
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _artistsDetailsBloc.add(ShowDetailsOfArtistsEvent(artistsId: artistsId));
    _imagesOfArtistsBloc.add(GetImagesOfArtistsEvent(artistsId: artistsId));
  }
}
