import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../model/tmdb_movie/artists/artists_details.dart';

class BasicInfoOfArtists extends StatelessWidget {
  const BasicInfoOfArtists({
    required this.artistsDetails,
    Key? key,
  }) : super(key: key);

  final ArtistsDetails artistsDetails;

  @override
  Widget build(BuildContext context) => Positioned(
    left: DimensionConstant.PADDING_16,
    bottom: DimensionConstant.PADDING_20,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          artistsDetails.name ?? 'NA',
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(
          height: DimensionConstant.HEIGHT_8,
        ),
        Text(
          '${artistsDetails.gender == 1 ? 'Actress' : 'Actor'} | '
              '${artistsDetails.birthday ?? 'NA'}',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
            fontSize: DimensionConstant.FONT_SIZE_17,
          ),
        )
      ],
    ),
  );
}
