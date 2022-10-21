import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../general/default_shimmer.dart';
import '../general/image_error.dart';

class BackGroundOnBoardingScreen extends StatelessWidget {
  const BackGroundOnBoardingScreen({
    required this.pathImage,
    Key? key,
  }) : super(key: key);

  final String pathImage;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          CachedNetworkImage(
            height: double.infinity,
            imageUrl: '${PathConstant.DEFAULT_URL_IMAGE}$pathImage',
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
          Container(
            color: Colors.black.withOpacity(DimensionConstant.OPACITY_0_DOT_6),
          ),
        ],
      );
}
