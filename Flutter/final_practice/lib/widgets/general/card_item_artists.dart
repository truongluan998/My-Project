import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../model/tmdb_movie/artists/person.dart';
import '../../theme/final_practice_color.dart';
import 'custom_border_radius_image.dart';

class CardItemArtists extends StatelessWidget {
  const CardItemArtists({
    required this.resList,
    required this.width,
    required this.maxLine,
    Key? key,
  }) : super(key: key);

  final Results resList;
  final double width;
  final int maxLine;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/artists_details',
            arguments: {
              'artists_id': resList.id!,
            },
          );
        },
        child: Card(
          color: FinalPracticeColor.whiteColor,
          child: SizedBox(
            width: width,
            child: Column(
              children: [
                CustomBorderRadiusImage(
                  url: resList.profilePath ?? '',
                ),
                const SizedBox(height: DimensionConstant.HEIGHT_4),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensionConstant.PADDING_8,
                  ),
                  child: Text(
                    resList.name ?? LabelConstant.NA,
                    textAlign: TextAlign.center,
                    maxLines: maxLine,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
