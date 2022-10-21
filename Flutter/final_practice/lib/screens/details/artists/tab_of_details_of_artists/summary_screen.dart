import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/tmdb_movie/details/artists/overview_details/artists_details_bloc.dart';
import '../../../../blocs/tmdb_movie/details/artists/overview_details/artists_details_event.dart';
import '../../../../blocs/tmdb_movie/details/artists/overview_details/artists_details_state.dart';
import '../../../../constants/constants.dart';
import '../../../../dependencies/app_dependencies.dart';
import '../../../../theme/final_practice_color.dart';
import '../../../../widgets/general/text_notification.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({
    required this.artistsId,
    Key? key,
  }) : super(key: key);

  final int artistsId;

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen>
    with AutomaticKeepAliveClientMixin, AfterLayoutMixin {
  late final ArtistsDetailsBloc _artistsDetailsBloc;

  @override
  void initState() {
    _artistsDetailsBloc = AppDependencies.injector.get<ArtistsDetailsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder(
          bloc: _artistsDetailsBloc,
          builder: (context, state) {
            if (state is ShowArtistsDetailsLoadingState) {
              return const TextNotification(text: LabelConstant.LOADING);
            }
            if (state is ShowArtistsDetailsSuccessState) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: FinalPracticeColor.backgroundScaffoldColor,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: DimensionConstant.PADDING_20,
                      horizontal: DimensionConstant.PADDING_16,
                    ),
                    child: Text(
                      state.artistsDetails!.biography ?? '',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              );
            }
            if (state is ShowArtistsDetailsFailState) {
              return TextNotification(text: state.message);
            }
            return Container();
          },
        ),
      );

  @override
  bool get wantKeepAlive => true;

  @override
  void afterFirstLayout(BuildContext context) {
    _artistsDetailsBloc
        .add(ShowDetailsOfArtistsEvent(artistsId: widget.artistsId));
  }
}
