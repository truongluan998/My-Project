import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/size_config.dart';
import '../../../const/constants.dart';
import '../../../data/data.dart';
import '../../../models/support.dart';
import '../../../theme/netflix_clone_color.dart';
import '../../../widgets/onboarding_screen/help_screen/custom_contact_button.dart';
import '../../../widgets/onboarding_screen/help_screen/custom_title.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  static const String routeName = '/help';

  static Route route() => MaterialPageRoute(
        builder: (_) => const HelpScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  Widget build(BuildContext context) {
    final _dataSupportList = supportList;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: SvgPicture.asset(
            PathConstant.LOGO_NETFLIX,
            height: DimensionConstant.SIZE_24,
            width: DimensionConstant.SIZE_24,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensionConstant.PADDING_12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CustomTitle(
                text: LabelConstant.FIND_HELP_ONLINE,
              ),
              _SupportList(supportList: _dataSupportList),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: DimensionConstant.PADDING_16,
                ),
                child: _ContactNetflixService(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactNetflixService extends StatelessWidget {
  const _ContactNetflixService({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const CustomTitle(
            text: LabelConstant.CONTACT_TITLE,
          ),
          const SizedBox(
            height: DimensionConstant.HEIGHT_32,
          ),
          Text(
            LabelConstant.CONTACT_DESCRIPTION,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: DimensionConstant.HEIGHT_16,
          ),
          CustomContactButton(
            icon: Icons.message,
            press: () {
              _showDialogConnectSupport(LabelConstant.CHAT_NOW, context);
            },
            text: LabelConstant.CHAT,
          ),
          const SizedBox(
            height: DimensionConstant.PADDING_8,
          ),
          CustomContactButton(
            icon: Icons.call,
            press: () {
              _showDialogConnectSupport(LabelConstant.CALL_NOW, context);
            },
            text: LabelConstant.CALL,
          ),
          const SizedBox(
            height: DimensionConstant.HEIGHT_32,
          ),
        ],
      );

  Future<void> _showDialogConnectSupport(
    String typeConnect,
    BuildContext context,
  ) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: NetflixCloneColor.brownColor,
        title: Text(
          LabelConstant.CONNECT_TO_SUPPORT,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: DimensionConstant.FONT_SIZE_16,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              LabelConstant.CANCEL,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: DimensionConstant.FONT_SIZE_14,
                  ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              typeConnect,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: DimensionConstant.FONT_SIZE_14,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportList extends StatelessWidget {
  const _SupportList({
    required this.supportList,
    Key? key,
  }) : super(key: key);

  final List<Support> supportList;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight:
              SizeConfig.screenHeight * DimensionConstant.MAX_HEIGHT_0_DOT_38,
        ),
        child: ListView.separated(
          itemCount: supportList.length + DimensionConstant.OFF_SET_2,
          itemBuilder: (context, index) {
            if (index == DimensionConstant.OFF_SET_0 ||
                index == supportList.length + DimensionConstant.OFF_SET_1) {
              return Container();
            }
            return InkWell(
              onTap: () {
                openURL(supportList[index - DimensionConstant.OFF_SET_1].url);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: DimensionConstant.PADDING_10,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimensionConstant.PADDING_16,
                      ),
                      child: Icon(
                        supportList[index - DimensionConstant.OFF_SET_1].icon,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Text(
                      supportList[index - DimensionConstant.OFF_SET_1].text,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: DimensionConstant.FONT_SIZE_14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            height: DimensionConstant.HEIGHT_1,
          ),
        ),
      );
}
