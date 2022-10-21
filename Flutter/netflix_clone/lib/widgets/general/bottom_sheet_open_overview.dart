import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/film_overview_bloc/film_overview_bloc.dart';
import '../../config/size_config.dart';
import '../../const/constants.dart';
import '../../models/content_model.dart';
import '../../theme/netflix_clone_color.dart';
import 'custom_text_details_small.dart';
import 'gesturedetector_icon.dart';
import 'play_button.dart';
import 'vertical_icon_button.dart';

class BottomSheetOpenOverview extends StatelessWidget {
  const BottomSheetOpenOverview({
    required this.featuredContent,
    required this.widget,
    Key? key,
    this.listContent,
  }) : super(key: key);

  final Content featuredContent;
  final Widget widget;
  final List<Content>? listContent;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          BlocProvider.of<FilmOverviewBloc>(context)
              .add(OpenOverviewFilm(contentID: featuredContent.id));
          showModalBottomSheet(
            barrierColor: Colors.transparent,
            backgroundColor: NetflixCloneColor.backgroundBottomSheetColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(DimensionConstant.BORDER_RADIUS_16),
                topLeft: Radius.circular(DimensionConstant.BORDER_RADIUS_16),
              ),
            ),
            context: context,
            builder: (context) =>
                BlocBuilder<FilmOverviewBloc, FilmOverviewState>(
              builder: (ctx, state) {
                if (state is FilmOverviewLoading) {}
                if (state is FilmOverviewLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(DimensionConstant.PADDING_12),
                    child: SizedBox(
                      height: SizeConfig.screenHeight > 1200
                          ? SizeConfig.screenHeight *
                              DimensionConstant
                                  .HEIGHT_OF_BOTTOM_SHEET_OVERVIEW_FILM
                          : SizeConfig.screenHeight *
                              DimensionConstant
                                  .HEIGHT_OF_BOTTOM_SHEET_OVERVIEW_FILM_38,
                      child: Stack(
                        children: [
                          _DetailsOverviewOfFilm(
                            featuredContent: featuredContent,
                          ),
                          Positioned(
                            top: DimensionConstant.POSITIONED_0,
                            right: DimensionConstant.POSITIONED_0,
                            child: Container(
                              width: DimensionConstant.SIZE_28,
                              height: DimensionConstant.SIZE_28,
                              decoration: const BoxDecoration(
                                color: NetflixCloneColor.brownColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    DimensionConstant.BORDER_RADIUS_20,
                                  ),
                                ),
                              ),
                              child: GestureDetectorIcon(
                                press: () => Navigator.pop(context),
                                icon: Icons.close,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          );
        },
        child: widget,
      );
}

class _DetailsOverviewOfFilm extends StatelessWidget {
  const _DetailsOverviewOfFilm({
    required this.featuredContent,
    Key? key,
  }) : super(key: key);

  final Content featuredContent;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  DimensionConstant.BORDER_RADIUS_4,
                ),
                child: Image.asset(
                  featuredContent.imageUrl,
                  width: DimensionConstant.WIDTH_92,
                  height: DimensionConstant.HEIGHT_132,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensionConstant.PADDING_16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        featuredContent.name,
                        style: Theme.of(context).textTheme.headline3,
                        maxLines: DimensionConstant.MAX_LINES_2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: const [
                          CustomTextDetailsSmall(
                            text: '2018',
                          ),
                          SizedBox(
                            width: DimensionConstant.WIDTH_12,
                          ),
                          CustomTextDetailsSmall(
                            text: '13+',
                          ),
                          SizedBox(
                            width: DimensionConstant.WIDTH_12,
                          ),
                          CustomTextDetailsSmall(
                            text: '3 Seasons',
                          ),
                        ],
                      ),
                      Text(
                        featuredContent.description!,
                        maxLines: DimensionConstant.MAX_LINES_4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: DimensionConstant.PADDING_8,
              bottom: DimensionConstant.PADDING_8,
              right: DimensionConstant.PADDING_24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PlayButton(
                  paddingRight: DimensionConstant.PADDING_52,
                  paddingLeft: DimensionConstant.PADDING_52,
                ),
                VerticalIconButton(
                  icon: Icons.download_outlined,
                  title: LabelConstant.DOWNLOAD,
                  press: () {},
                ),
                VerticalIconButton(
                  icon: Icons.play_arrow_outlined,
                  title: LabelConstant.PREVIEW,
                  press: () {},
                ),
              ],
            ),
          ),
          const Divider(
            color: NetflixCloneColor.brownLightColor,
            height: DimensionConstant.HEIGHT_2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DimensionConstant.PADDING_8,
            ),
            child: Row(
              children: [
                GestureDetectorIcon(
                  icon: Icons.info_outline,
                  press: () {},
                ),
                const SizedBox(
                  width: DimensionConstant.WIDTH_8,
                ),
                const Text(
                  LabelConstant.EPISODES,
                  style: TextStyle(
                    fontSize: DimensionConstant.FONT_SIZE_15,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                GestureDetectorIcon(
                  icon: Icons.navigate_next_outlined,
                  press: () {},
                ),
              ],
            ),
          )
        ],
      );
}
