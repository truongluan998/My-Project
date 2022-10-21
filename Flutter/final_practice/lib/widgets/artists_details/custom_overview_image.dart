import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../model/tmdb_movie/artists/artists_images_artists.dart';
import '../../theme/final_practice_color.dart';
import 'custom_photo_albums.dart';

class CustomOverviewImage extends StatelessWidget {
  const CustomOverviewImage({
    required this.imagesOfArtists,
    Key? key,
  }) : super(key: key);

  final ImagesOfArtists imagesOfArtists;

  @override
  Widget build(BuildContext context) => Container(
    color: FinalPracticeColor.backgroundScaffoldColor,
    width: SizeConfig.screenWidth * 0.7,
    child: (imagesOfArtists.profiles!.length == 1)
        ? CachedImage(
      height: double.infinity,
      width: double.infinity,
      boxFit: BoxFit.contain,
      urlImage: imagesOfArtists.profiles![0].filePath ?? '',
    )
        : (imagesOfArtists.profiles!.length == 2)
        ? Row(
      children: [
        CachedImage(
          height: double.infinity,
          width: SizeConfig.screenWidth * 0.35,
          boxFit: BoxFit.cover,
          urlImage: imagesOfArtists.profiles![0].filePath ?? '',
        ),
        CachedImage(
          height: double.infinity,
          width: SizeConfig.screenWidth * 0.35,
          boxFit: BoxFit.cover,
          urlImage: imagesOfArtists.profiles![1].filePath ?? '',
        ),
      ],
    )
        : (imagesOfArtists.profiles!.length == 3)
        ? Row(
      children: [
        CachedImage(
          urlImage:
          imagesOfArtists.profiles![0].filePath ?? '',
          boxFit: BoxFit.cover,
          width: SizeConfig.screenWidth * 0.35,
          height: double.infinity,
        ),
        Column(
          children: [
            CachedImage(
              urlImage:
              imagesOfArtists.profiles![1].filePath ?? '',
              boxFit: BoxFit.cover,
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.075,
            ),
            CachedImage(
              urlImage:
              imagesOfArtists.profiles![2].filePath ?? '',
              boxFit: BoxFit.cover,
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.075,
            ),
          ],
        )
      ],
    )
        : (imagesOfArtists.profiles!.length == 4)
        ? Row(
      children: [
        CachedImage(
          urlImage:
          imagesOfArtists.profiles![0].filePath ?? '',
          boxFit: BoxFit.cover,
          width: SizeConfig.screenWidth * 0.175,
          height: double.infinity,
        ),
        CachedImage(
          urlImage:
          imagesOfArtists.profiles![1].filePath ?? '',
          boxFit: BoxFit.cover,
          width: SizeConfig.screenWidth * 0.175,
          height: double.infinity,
        ),
        CachedImage(
          urlImage:
          imagesOfArtists.profiles![2].filePath ?? '',
          boxFit: BoxFit.cover,
          width: SizeConfig.screenWidth * 0.175,
          height: double.infinity,
        ),
        CachedImage(
          urlImage:
          imagesOfArtists.profiles![3].filePath ?? '',
          boxFit: BoxFit.cover,
          width: SizeConfig.screenWidth * 0.175,
          height: double.infinity,
        )
      ],
    )
        : (imagesOfArtists.profiles!.length >= 5)
        ? Row(
      children: [
        CachedImage(
          urlImage:
          imagesOfArtists.profiles![0].filePath ??
              '',
          boxFit: BoxFit.cover,
          width: SizeConfig.screenWidth * 0.3,
          height: double.infinity,
        ),
        Column(
          children: [
            Row(
              children: [
                CachedImage(
                  urlImage: imagesOfArtists
                      .profiles![1].filePath ??
                      '',
                  boxFit: BoxFit.cover,
                  width: SizeConfig.screenWidth * 0.2,
                  height:
                  SizeConfig.screenHeight * 0.075,
                ),
                CachedImage(
                  urlImage: imagesOfArtists
                      .profiles![2].filePath ??
                      '',
                  boxFit: BoxFit.cover,
                  width: SizeConfig.screenWidth * 0.2,
                  height:
                  SizeConfig.screenHeight * 0.075,
                ),
              ],
            ),
            Row(
              children: [
                CachedImage(
                  urlImage: imagesOfArtists
                      .profiles![3].filePath ??
                      '',
                  boxFit: BoxFit.cover,
                  width: SizeConfig.screenWidth * 0.2,
                  height:
                  SizeConfig.screenHeight * 0.075,
                ),
                CachedImage(
                  urlImage: imagesOfArtists
                      .profiles![4].filePath ??
                      '',
                  boxFit: BoxFit.cover,
                  width: SizeConfig.screenWidth * 0.2,
                  height:
                  SizeConfig.screenHeight * 0.075,
                ),
              ],
            )
          ],
        )
      ],
    )
        : Container(),
  );
}
