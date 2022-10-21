import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'default_shimmer.dart';
import 'image_error.dart';

class CustomBorderRadiusImage extends StatelessWidget {
  const CustomBorderRadiusImage({
    required this.url,
    Key? key,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            DimensionConstant.BORDER_RADIUS_4,
          ),
          topRight: Radius.circular(
            DimensionConstant.BORDER_RADIUS_4,
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: '${PathConstant.DEFAULT_URL_IMAGE}'
              '$url',
          width: double.infinity,
          height: DimensionConstant.HEIGHT_204,
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
