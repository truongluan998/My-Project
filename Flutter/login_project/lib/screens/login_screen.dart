import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:login_project/config/theme_config.dart';
import 'package:login_project/controller/authentication_controller.dart';
import 'package:login_project/dependencies/app_dependencies.dart';
import 'package:login_project/theme/login_app_color.dart';
import 'package:login_project/utils/utils.dart';
import 'package:login_project/widget/custom_circular_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../config/size_config.dart';
import '../constants/constants.dart';
import '../utils/enum.dart';
import '../widget/custom_title.dart';
import '../widget/custom_back_button.dart';
import '../widget/custom_action_button.dart';
import '../widget/login/custom_balloons.dart';
import '../widget/login/custom_divider_and_text.dart';
import '../widget/login/do_not_have_account_text.dart';
import '../widget/login/login_with_social_network_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  static Route route() => MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late final AuthenticationController _authenticationController;

  @override
  void initState() {
    super.initState();
    _authenticationController = AppDependencies.getIt.get<AuthenticationController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _checkValidUser();
    });
  }

  Future<void> _checkValidUser() async {
    await _authenticationController.checkUser();
    if (_authenticationController.statusAuthentication == ListStatusAuthentication.logged) {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/category',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Utils.setConfigApp(context);
    if (SizeConfig.screenWidth == null || ThemeConfig.textTheme.bodyText1 == null) {
      Utils.setConfigApp(context);
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ChangeNotifierProvider.value(
          value: _authenticationController,
          child: Stack(
            children: [
              Positioned(
                top: SizeConfig.screenHeight! * Dimens.posNegativeTopBalloonThree,
                left: SizeConfig.screenWidth! * Dimens.posNegativeLeftBalloonThree,
                child: Container(
                  width: Dimens.size96,
                  height: Dimens.size96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: LoginAppColor.balloonTwoColor,
                      width: Dimens.size36,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: SizeConfig.screenHeight! * Dimens.posNegativeTopBalloonOne,
                left: SizeConfig.screenWidth! * Dimens.posNegativeLeftBalloonOne,
                child: const CustomBalloons(
                  width: Dimens.size165,
                  height: Dimens.size165,
                  color: LoginAppColor.balloonOneColor,
                ),
              ),
              Positioned(
                top: SizeConfig.screenHeight! * Dimens.posNegativeTopBalloonTwo,
                left: SizeConfig.screenWidth! * Dimens.posLeftBalloonTwo,
                child: const CustomBalloons(
                  width: Dimens.size181,
                  height: Dimens.size181,
                  color: LoginAppColor.balloonTwoColor,
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: Dimens.size36,
                    left: Dimens.size26,
                    bottom: Dimens.size28,
                    right: Dimens.size26,
                  ),
                  child: Consumer<AuthenticationController>(
                    builder: (context, data, _) {
                      return data.isLoading
                          ? const CustomCircularProgressIndicator()
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomBackButton(
                                    press: () {},
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight! * Dimens.size0Dot13),
                                  CustomTitle(
                                    title: tr('login_screen.login_title'),
                                    textTheme: ThemeConfig.textTheme.headline2,
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight! * Dimens.size0Dot04),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTitle(
                                        title: tr('login_screen.login_email'),
                                        textTheme: ThemeConfig.textTheme.headline6,
                                      ),
                                      const SizedBox(height: Dimens.size4),
                                      Material(
                                        elevation: Dimens.size1,
                                        color: LoginAppColor.whiteColor,
                                        shadowColor: LoginAppColor.textFormFieldShadow.withOpacity(Dimens.opa0Dot2),
                                        borderRadius: BorderRadius.circular(Dimens.size10),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          controller: _email,
                                          keyboardType: TextInputType.emailAddress,
                                          cursorColor: LoginAppColor.blackColor,
                                          style: ThemeConfig.textTheme.bodyText1,
                                          decoration: InputDecoration(
                                            hintStyle: ThemeConfig.textTheme.subtitle1,
                                            hintText: tr('login_screen.login_email_hint'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight! * Dimens.size0Dot036),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTitle(
                                        title: tr('login_screen.login_password'),
                                        textTheme: ThemeConfig.textTheme.headline6,
                                      ),
                                      const SizedBox(height: Dimens.size4),
                                      Material(
                                        elevation: Dimens.size1,
                                        color: LoginAppColor.whiteColor,
                                        shadowColor: LoginAppColor.textFormFieldShadow.withOpacity(Dimens.opa0Dot2),
                                        borderRadius: BorderRadius.circular(Dimens.size10),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          controller: _password,
                                          keyboardType: TextInputType.emailAddress,
                                          cursorColor: LoginAppColor.blackColor,
                                          style: ThemeConfig.textTheme.bodyText1,
                                          obscureText: !data.isShowPass,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () => data.showPassword(),
                                              icon: Icon(
                                                data.isShowPass ? Icons.visibility_off : Icons.visibility,
                                              ),
                                            ),
                                            hintStyle: ThemeConfig.textTheme.subtitle1,
                                            hintText: tr('login_screen.login_password_hint'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight! * Dimens.size0Dot04),
                                  Center(
                                    child: InkWell(
                                      onTap: () {},
                                      child: CustomTitle(
                                        title: tr('login_screen.login_forgot_password'),
                                        textTheme: ThemeConfig.textTheme.bodyText2?.copyWith(
                                          color: LoginAppColor.balloonTwoColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight! * Dimens.size0Dot04),
                                  Center(
                                    child: CustomActionButton(
                                      title: tr('login_screen.login_title'),
                                      height: Dimens.size52,
                                      width: SizeConfig.screenWidth! * Dimens.size0Dot66,
                                      textTheme: ThemeConfig.textTheme.bodyText1!.copyWith(
                                        color: LoginAppColor.whiteColor,
                                      ),
                                      press: () async {
                                        await data.loginUser(
                                          _email.text,
                                          _password.text,
                                        );
                                        switch (data.statusAuthentication) {
                                          case ListStatusAuthentication.fail:
                                            Utils.showToast(tr('login_screen.login_fail'));
                                            break;
                                          case ListStatusAuthentication.success:
                                            if (!mounted) return;
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/category',
                                              (route) => false,
                                            );
                                            break;
                                          case ListStatusAuthentication.wrongEmail:
                                            Utils.showToast(tr('login_screen.wrong_email'));
                                            break;
                                          case ListStatusAuthentication.logged:
                                            break;
                                          case ListStatusAuthentication.initial:
                                            break;
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight! * Dimens.size0Dot045),
                                  Center(
                                    child: DoNotHaveAccountText(
                                      press: () {},
                                    ),
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight! * Dimens.size0Dot045),
                                  CustomDividerAndText(title: tr('login_screen.sign_in_with')),
                                  const SizedBox(height: Dimens.size16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      LoginWithSocialNetworkButton(
                                        title: tr('login_screen.facebook'),
                                        image: ImagesAsset.facebookAsset,
                                        press: () {},
                                      ),
                                      LoginWithSocialNetworkButton(
                                        title: tr('login_screen.google'),
                                        image: ImagesAsset.googleAsset,
                                        press: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _authenticationController.dispose();
    super.dispose();
  }
}
