import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../constants/constants.dart';
import '../../model/tmdb_movie/artists/artists_images_artists.dart';
import '../../theme/final_practice_color.dart';
import '../general/default_shimmer.dart';
import '../general/image_error.dart';

class CustomPhotoAlbums extends StatelessWidget {
  const CustomPhotoAlbums({
    required this.imagesOfArtists,
    required this.artistsId,
    Key? key,
  }) : super(key: key);

  final ImagesOfArtists imagesOfArtists;
  final int artistsId;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          '/gallery',
          arguments: {'artists_id': artistsId},
        ),
        child: SizedBox(
          width: SizeConfig.screenWidth * DimensionConstant.WIDTH_0_DOT_3,
          child: Stack(
            children: [
              CachedImage(
                width: double.infinity,
                height: double.infinity,
                boxFit: BoxFit.cover,
                urlImage: imagesOfArtists.profiles![0].filePath ?? '',
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: FinalPracticeColor.primaryButtonColor
                        .withOpacity(DimensionConstant.OPACITY_0_DOT_9),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${imagesOfArtists.profiles!.length}+',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(
                        height: DimensionConstant.HEIGHT_16,
                      ),
                      Text(
                        LabelConstant.PHOTO_ALBUMS,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: FinalPracticeColor.whiteColor),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
}

class CachedImage extends StatelessWidget {
  const CachedImage({
    required this.urlImage,
    required this.boxFit,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  final String urlImage;
  final BoxFit boxFit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: '${PathConstant.DEFAULT_URL_IMAGE}$urlImage',
        width: width,
        height: height,
        fit: boxFit,
        placeholder: (context, url) => DefaultShimmer(
          widget: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, dynamic error) => const ImageError(),
      );
}
