import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../blocs/authentication_bloc/authentication/authentication_bloc.dart';
import '../config/size_config.dart';
import '../const/constants.dart';
import '../theme/netflix_clone_color.dart';
import '../utils/validators.dart';
import '../widgets/general/app_circular_progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/splash';

  static Route route() => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer(
      bloc: _authenticationBloc,
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          if (state.exception == ListExceptionAuthentication.noUser) {
            _showModalBottomSheetLoginWithGoogleAccount(
              context,
              _authenticationBloc,
            );
          }
          if (state.exception ==
              ListExceptionAuthentication.failAuthentication) {
            showToast(state.message);
          }
        }
        if (state is AuthenticationSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
          );
          showToast(
            '${LabelConstant.WELCOME}'
            '${state.authenticationDetail.name!.isEmpty
                ? state.authenticationDetail.email
                : state.authenticationDetail.name!}',
          );
        }
      },
      builder: (context, state) {
        if (state is AuthenticationInitial) {
          _authenticationBloc.add(AuthenticationStarted());
        }
        if (state is AuthenticationLoading) {
          return const Center(child: AppCircularProgressIndicator());
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: DimensionConstant.WIDTH_200,
                  height: DimensionConstant.HEIGHT_200,
                  child: SvgPicture.asset(PathConstant.LOGO_NETFLIX),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showModalBottomSheetLoginWithGoogleAccount(
    BuildContext context,
    AuthenticationBloc bloc,
  ) =>
      showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        barrierColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(DimensionConstant.BORDER_RADIUS_16),
            topLeft: Radius.circular(DimensionConstant.BORDER_RADIUS_16),
          ),
        ),
        context: context,
        builder: (context) => SizedBox(
          height: SizeConfig.screenHeight > DimensionConstant.HEIGHT_1200
              ? SizeConfig.screenHeight *
                  DimensionConstant
                      .HEIGHT_OF_BOTTOM_SHEET_LOGIN_WITH_GOOGLE_ACCOUNT
              : SizeConfig.screenHeight *
                  DimensionConstant
                      .HEIGHT_OF_BOTTOM_SHEET_LOGIN_WITH_GOOGLE_ACCOUNT_40,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DimensionConstant.PADDING_12,
            ),
            child: BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is AuthenticationLoading) {
                  return const AbsorbPointer(
                    child: _ContentBottomSheetLoginAccount(),
                  );
                } else {
                  return const _ContentBottomSheetLoginAccount();
                }
              },
            ),
          ),
        ),
      ).whenComplete(() async {
        await Future.delayed(const Duration(milliseconds: 400));
        if (!mounted) {
          return;
        }
        await Navigator.pushNamedAndRemoveUntil(
          context,
          '/on_boarding',
          (route) => false,
        );
      });
}

class _ContentBottomSheetLoginAccount extends StatelessWidget {
  const _ContentBottomSheetLoginAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensionConstant.PADDING_16,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      PathConstant.ICON_GOOGLE,
                      width: DimensionConstant.SIZE_24,
                      height: DimensionConstant.SIZE_24,
                    ),
                    const SizedBox(
                      width: DimensionConstant.WIDTH_8,
                    ),
                    const Text(
                      LabelConstant.SIGN_IN_WITH_GOOGLE,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: DimensionConstant.FONT_SIZE_16,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: NetflixCloneColor.brownColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensionConstant.PADDING_16,
                ),
                child: Column(
                  children: [
                    const Text(
                      LabelConstant.SIGN_INTO_NETFLIX,
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: DimensionConstant.HEIGHT_4,
                    ),
                    const Text(
                      LabelConstant.SAVE_NETFLIX_PASSWORD_IN_GOOGLE,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: DimensionConstant.FONT_SIZE_14,
                      ),
                    ),
                    const SizedBox(
                      height: DimensionConstant.HEIGHT_12,
                    ),
                    _CustomButtonLogin(
                      text: LabelConstant.LOGIN_WITH_GOOGLE,
                      press: () =>
                          BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationNewAccountSignInWithGoogle(),
                      ),
                    ),
                    const SizedBox(
                      height: DimensionConstant.HEIGHT_4,
                    ),
                    _CustomButtonLogin(
                      text: LabelConstant.LOGIN_WITH_FACEBOOK,
                      press: () =>
                          BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationNewAccountSignInWithFacebook(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: DimensionConstant.POSITIONED_MINUS_9,
            right: DimensionConstant.POSITIONED_0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: NetflixCloneColor.brownLightColor,
              ),
            ),
          )
        ],
      );
}

class _CustomButtonLogin extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const _CustomButtonLogin({
    required this.text,
    required this.press,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: MaterialButton(
          padding: const EdgeInsets.all(
            DimensionConstant.PADDING_6,
          ),
          color: Colors.blueAccent,
          onPressed: press,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
}
