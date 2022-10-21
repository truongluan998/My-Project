import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../general/default_shimmer.dart';
import '../../general/image_error.dart';

class ReviewCircleAvatar extends StatelessWidget {
  const ReviewCircleAvatar({
    required this.pathImage,
    Key? key,
  }) : super(key: key);

  final String pathImage;

  @override
  Widget build(BuildContext context) => Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            imageUrl: '${PathConstant.DEFAULT_URL_IMAGE}'
                '$pathImage',
            width: double.infinity,
            height: double.infinity,
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
        ),
      );
}
