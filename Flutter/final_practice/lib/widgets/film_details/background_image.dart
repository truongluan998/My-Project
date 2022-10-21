import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../general/default_shimmer.dart';
import '../general/image_error.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    required this.imagePath,
    required this.heightOfImage,
    Key? key,
  }) : super(key: key);

  final String imagePath;
  final double heightOfImage;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: heightOfImage,
        child: CachedNetworkImage(
          height: double.infinity,
          imageUrl: '${PathConstant.DEFAULT_URL_IMAGE}$imagePath',
          fit: BoxFit.cover,
          placeholder: (context, url) => DefaultShimmer(
            widget: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => const ImageError(),
        ),
      );
}
