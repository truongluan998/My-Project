import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/size_config.dart';
import '../../../const/constants.dart';
import '../../../models/content_model.dart';
import '../../../theme/netflix_clone_color.dart';
import '../../../widgets/general/bottom_sheet_open_overview.dart';
import '../../../widgets/general/play_button.dart';
import '../../../widgets/general/vertical_icon_button.dart';

class ContentHeader extends StatelessWidget {
  const ContentHeader({
    required this.featuredContent,
    Key? key,
  }) : super(key: key);

  final Content featuredContent;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: SizeConfig.screenHeight *
                DimensionConstant.HEIGHT_OF_IMAGE_BACKGROUND_HOME,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(featuredContent.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BottomSheetOpenOverview(
            featuredContent: featuredContent,
            widget: Container(
              height: SizeConfig.screenHeight *
                  DimensionConstant.HEIGHT_OF_IMAGE_BACKGROUND_HOME,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom:
                SizeConfig.screenHeight * DimensionConstant.HEIGHT_14_PERCENT,
            child: Image.asset(
              featuredContent.titleImageUrl!,
              width: DimensionConstant.WIDTH_250,
            ),
          ),
          Positioned(
            left: DimensionConstant.POSITIONED_0,
            right: DimensionConstant.POSITIONED_0,
            bottom: SizeConfig.screenHeight *
                DimensionConstant.HEIGHT_8_DOT_5_PERCENT,
            child: Center(
              child: _GenreListOfFilm(
                featuredContent: featuredContent,
              ),
            ),
          ),
          Positioned(
            left: DimensionConstant.POSITIONED_0,
            right: DimensionConstant.POSITIONED_0,
            bottom:
                SizeConfig.screenHeight * DimensionConstant.HEIGHT_3_PERCENT,
            child: Padding(
              padding: const EdgeInsets.only(
                left: DimensionConstant.PADDING_16,
                right: DimensionConstant.PADDING_32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  VerticalIconButton(
                    icon: Icons.add_outlined,
                    title: LabelConstant.MY_LIST,
                    press: () {},
                  ),
                  const PlayButton(
                    paddingRight: DimensionConstant.PADDING_16,
                    paddingLeft: DimensionConstant.PADDING_8,
                  ),
                  VerticalIconButton(
                    icon: Icons.info_outline,
                    title: LabelConstant.INFO,
                    press: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      );
}

class _GenreListOfFilm extends StatelessWidget {
  const _GenreListOfFilm({
    required this.featuredContent,
    Key? key,
  }) : super(key: key);

  final Content featuredContent;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: DimensionConstant.HEIGHT_48,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensionConstant.PADDING_16,
          ),
          itemCount: featuredContent.genre!.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => Row(
            children: [
              //If index = 0, separator button will not display
              if (index == 0)
                Visibility(
                  visible: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensionConstant.PADDING_8,
                    ),
                    child: Text(
                      featuredContent.genre![index],
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: DimensionConstant.FONT_SIZE_12),
                    ),
                  ),
                )
              else
                Container(
                  width: DimensionConstant.WIDTH_4,
                  height: DimensionConstant.HEIGHT_4,
                  decoration: BoxDecoration(
                    color: NetflixCloneColor.brownColor,
                    borderRadius: BorderRadius.circular(
                      DimensionConstant.BORDER_RADIUS_20,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensionConstant.PADDING_8,
                ),
                child: Text(
                  featuredContent.genre![index],
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: DimensionConstant.FONT_SIZE_12),
                ),
              )
            ],
          ),
        ),
      );
}
