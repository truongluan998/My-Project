import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../blocs/tmdb_movie/details/artists/images/images_of_artists_bloc.dart';
import '../../../blocs/tmdb_movie/details/artists/images/images_of_artists_event.dart';
import '../../../blocs/tmdb_movie/details/artists/images/images_of_artists_state.dart';
import '../../../constants/constants.dart';
import '../../../dependencies/app_dependencies.dart';
import '../../../model/tmdb_movie/artists/artists_images_artists.dart';
import '../../../theme/final_practice_color.dart';
import '../../../widgets/artists_details/custom_photo_albums.dart';
import '../../../widgets/general/app_circular_progress_indcator.dart';
import '../../../widgets/general/text_notification.dart';

class GalleryImageOfArtists extends StatefulWidget {
  const GalleryImageOfArtists({Key? key}) : super(key: key);

  static const String routeName = '/gallery';

  static Route route() => MaterialPageRoute(
        builder: (_) => const GalleryImageOfArtists(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<GalleryImageOfArtists> createState() => _GalleryImageOfArtistsState();
}

class _GalleryImageOfArtistsState extends State<GalleryImageOfArtists>
    with AfterLayoutMixin {
  late final ImagesOfArtistsBloc _imagesOfArtistsBloc;
  late final int _artistsId;

  @override
  void initState() {
    _imagesOfArtistsBloc = AppDependencies.injector.get<ImagesOfArtistsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map;
    _artistsId = arguments['artists_id'];
    return Scaffold(
      appBar: AppBar(
        elevation: DimensionConstant.ELEVATION_0,
        title: Text(
          'Photo Album',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: DimensionConstant.PADDING_12),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Container(
        color: FinalPracticeColor.backgroundScaffoldColor,
        child: BlocBuilder(
          bloc: _imagesOfArtistsBloc,
          builder: (context, state) {
            if (state is ShowImagesOfArtistsLoadingState) {
              return const AppCircularProgressIndicator();
            }
            if (state is ShowImagesOfArtistsSuccessState) {
              return GridView.builder(
                padding: const EdgeInsets.all(DimensionConstant.PADDING_16),
                itemCount: state.imagesOfArtists!.profiles!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: DimensionConstant.CROSS_AXIS_COUNT_3,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: DimensionConstant.CROSS_AXIS_SPACING_8,
                  mainAxisSpacing: DimensionConstant.MAIN_AXIS_SPACING_8,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => _GalleryWidget(
                        urlImages: state.imagesOfArtists!.profiles!,
                        currentImage: index,
                      ),
                    ),
                  ),
                  child: SizedBox(
                    child: CachedImage(
                      boxFit: BoxFit.cover,
                      urlImage:
                          state.imagesOfArtists!.profiles![index].filePath ??
                              '',
                    ),
                  ),
                ),
              );
            }
            if (state is ShowImagesOfArtistsFailState) {
              return TextNotification(text: state.message);
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _imagesOfArtistsBloc.add(GetImagesOfArtistsEvent(artistsId: _artistsId));
  }
}

class _GalleryWidget extends StatefulWidget {
  _GalleryWidget({
    required this.urlImages,
    required this.currentImage,
    Key? key,
  })  : pageController = PageController(initialPage: currentImage),
        super(key: key);

  final List<Profiles> urlImages;
  final int currentImage;
  final PageController pageController;

  @override
  State<_GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<_GalleryWidget> {
  late int index = widget.currentImage;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: DimensionConstant.PADDING_12),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              pageController: widget.pageController,
              itemCount: widget.urlImages.length,
              builder: (context, index) {
                final urlImage = widget.urlImages[index].filePath;
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(
                    '${PathConstant.DEFAULT_URL_IMAGE}${urlImage ?? ''}',
                  ),
                );
              },
              onPageChanged: (index) => setState(() => this.index = index),
            ),
            Positioned(
              right: DimensionConstant.PADDING_4,
              bottom: DimensionConstant.PADDING_40,
              child: Container(
                padding: const EdgeInsets.all(DimensionConstant.PADDING_16),
                child: Text(
                  'Image ${index + 1}/${widget.urlImages.length}',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            )
          ],
        ),
      );
}
