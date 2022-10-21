import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/widgets/general/leading_netflix_icon_in_appbar.dart';

import '../../blocs/authentication_bloc/sign_up/check_email_exits/check_email_exits_bloc.dart';
import '../../const/constants.dart';
import '../../theme/netflix_clone_color.dart';
import '../../utils/validators.dart';
import '../../widgets/general/app_button.dart';
import '../../widgets/general/app_circular_progress_indicator.dart';
import '../../widgets/onboarding_screen/appbar_text.dart';
import '../../widgets/onboarding_screen/richtext_underline.dart';
import 'on_boarding_screen/advertising_screen_four.dart';
import 'on_boarding_screen/advertising_screen_one.dart';
import 'on_boarding_screen/advertising_screen_three.dart';
import 'on_boarding_screen/advertising_screen_two.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  static const String routeName = '/on_boarding';

  static Route route() => MaterialPageRoute(
        builder: (_) => const OnBoardingScreen(),
        settings: const RouteSettings(name: routeName),
      );

  static const List<Tab> tabs = <Tab>[
    Tab(text: LabelConstant.ADVERTISING_SCREEN_ONE),
    Tab(text: LabelConstant.ADVERTISING_SCREEN_TWO),
    Tab(text: LabelConstant.ADVERTISING_SCREEN_THREE),
    Tab(text: LabelConstant.ADVERTISING_SCREEN_FOUR),
  ];

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final TextEditingController _email;

  late CheckEmailExitsBloc _checkEmailExitsBloc;

  final GlobalKey<FormState> _formKeyEmail = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _checkEmailExitsBloc = BlocProvider.of<CheckEmailExitsBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _onFormSubmitted() {
    if (_formKeyEmail.currentState!.validate()) {
      _checkEmailExitsBloc.add(
        PressToCheckEmail(
          email: _email.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: OnBoardingScreen.tabs.length,
        child: Builder(
          builder: (context) {
            final _tabController = DefaultTabController.of(context)!;
            _tabController.addListener(
              () {
                if (!_tabController.indexIsChanging) {
                  setState(() {});
                }
              },
            );
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                leading: const LeadingNetflixIconInAppBar(),
                actions: [
                  AppBarText(
                    text: LabelConstant.PRIVACY,
                    press: () => openURL(PathConstant.URL_PRIVACY_NETFLIX),
                  ),
                  AppBarText(
                    text: LabelConstant.HELP,
                    press: () {
                      Navigator.pushNamed(context, '/help');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: DimensionConstant.PADDING_8,
                    ),
                    child: AppBarText(
                      text: LabelConstant.SIGN_IN.toUpperCase(),
                      press: () {
                        Navigator.pushNamed(context, '/sign_in');
                      },
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  const Expanded(
                    child: TabBarView(
                      children: [
                        AdvertisingScreenOne(),
                        AdvertisingScreenTwo(),
                        AdvertisingScreenThree(),
                        AdvertisingScreenFour(),
                      ],
                    ),
                  ),
                  _buildDotsIndicatorOnBoarding(_tabController),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensionConstant.PADDING_16,
                      vertical: DimensionConstant.PADDING_12,
                    ),
                    child: Form(
                      key: _formKeyEmail,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _email,
                            cursorColor: NetflixCloneColor.brownLightColor,
                            keyboardType: TextInputType.emailAddress,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.black,
                                      fontSize: DimensionConstant.FONT_SIZE_16,
                                    ),
                            validator: (value) => value!.isEmpty
                                ? LabelConstant.EMAIL_IS_REQUIRED
                                : Validators.isValidEmail(value) == false
                                    ? LabelConstant.INVALID_EMAIL
                                    : null,
                            decoration: inputDecorationTextFormFieldAuthenLight(
                              context,
                              LabelConstant.EMAIL,
                              LabelConstant.EMAIL_HINT,
                            ),
                          ),
                          const SizedBox(
                            height: DimensionConstant.HEIGHT_12,
                          ),
                          BlocConsumer(
                            bloc: _checkEmailExitsBloc,
                            listener: (context, state) {
                              if (state is EmailAlreadyExists) {
                                Navigator.pushNamed(
                                  context,
                                  '/sign_in_already_email',
                                );
                              }
                              if (state is EmailDoesNotExists) {
                                Navigator.pushNamed(
                                  context,
                                  '/sign_up_account',
                                );
                              }
                              if (state is CheckEmailFail) {
                                showToast(state.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is CheckEmailExitsLoading) {
                                return const Center(
                                  child: AppCircularProgressIndicator(),
                                );
                              }
                              return AppButton(
                                text: LabelConstant.GET_STARTED,
                                press: _onFormSubmitted,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: DimensionConstant.PADDING_16,
                    ),
                    child: RichTextUnderline(),
                  ),
                ],
              ),
            );
          },
        ),
      );

  DotsIndicator _buildDotsIndicatorOnBoarding(TabController _tabController) =>
      DotsIndicator(
        dotsCount: OnBoardingScreen.tabs.length,
        position: _tabController.index.toDouble(),
        decorator: const DotsDecorator(
          spacing:
              EdgeInsets.symmetric(horizontal: DimensionConstant.PADDING_8),
          size: Size.square(DimensionConstant.SIZE_10),
          activeSize: Size.square(DimensionConstant.SIZE_10),
          activeColor: Colors.grey,
          color: NetflixCloneColor.brownColor,
        ),
      );
}
