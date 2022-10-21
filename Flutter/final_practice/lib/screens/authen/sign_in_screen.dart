import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication/authentication_bloc.dart';
import '../../blocs/authentication/authentication/authentication_event.dart';
import '../../blocs/authentication/authentication/authentication_state.dart';
import '../../constants/constants.dart';
import '../../dependencies/app_dependencies.dart';
import '../../theme/final_practice_color.dart';
import '../../utility/exception.dart';
import '../../utility/utility.dart';
import '../../widgets/general/app_authen_button.dart';
import '../../widgets/general/app_authen_with_media_social_button.dart';
import '../../widgets/general/authen_method_title.dart';
import '../../widgets/general/have_an_account_or_not.dart';
import '../../widgets/general/layer_invisible_loading.dart';
import '../../widgets/sign_in/forgot_password_text_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const String routeName = '/sign_in';

  static Route route() => MaterialPageRoute(
        builder: (_) => const SignInScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final Utils _utils;
  late final AuthenticationBloc _authenticationBloc;

  late bool _passwordVisible;

  final GlobalKey<FormState> _formKeySignIn = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _authenticationBloc = AppDependencies.injector.get<AuthenticationBloc>();
    _utils = AppDependencies.injector.get<Utils>();
    _passwordVisible = false;
    super.initState();
  }

  void _onFormSubmitted() {
    _authenticationBloc.add(
      SignInWithCredentialsPressedEvent(
        email: _email.text,
        password: _password.text,
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: _utils.buildBackgroundAuthenScreen(),
          child: BlocConsumer(
            bloc: _authenticationBloc,
            listener: (context, state) {
              if (state is AuthenticationFailureState) {
                if (state.exception ==
                    ListExceptionAuthentication.failAuthentication) {
                  _utils.showToast(
                    state.message,
                  );
                }
              }
              if (state is AuthenticationSuccessState) {
                _utils.getPrefsToOpenOnBoarding('key_on_boarding').then(
                  (value) {
                    if (value == true) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/main',
                        (route) => false,
                      );
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/on_boarding',
                        (route) => false,
                      );
                    }
                  },
                );
              }
            },
            builder: (context, state) => Stack(
              children: [
                Container(
                  color: Colors.black
                      .withOpacity(DimensionConstant.OPACITY_0_DOT_5),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: DimensionConstant.PADDING_40,
                    left: DimensionConstant.PADDING_40,
                    right: DimensionConstant.PADDING_40,
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: _formSignIn(state, context),
                    ),
                  ),
                ),
                if (state is AuthenticationLoadingState)
                  const LayerInvisibleLoading()
              ],
            ),
          ),
        ),
      );

  Form _formSignIn(state, BuildContext context) => Form(
        key: _formKeySignIn,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: DimensionConstant.HEIGHT_20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              cursorColor: FinalPracticeColor.brownLightColor,
              validator: (value) {
                if (state is AuthenticationFailureState) {
                  if (state.exception ==
                      ListExceptionAuthentication.emailInvalid) {
                    return state.message;
                  }
                }
                if (value!.isEmpty) {
                  return LabelConstant.EMAIL_MUST_NOT_EMPTY;
                } else {
                  return null;
                }
              },
              decoration: _utils.inputDecorationTextFormFieldAuthen(
                context,
                LabelConstant.EMAIL,
              ),
            ),
            const SizedBox(
              height: DimensionConstant.HEIGHT_48,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: _password,
              keyboardType: TextInputType.emailAddress,
              obscureText: !_passwordVisible,
              cursorColor: FinalPracticeColor.brownLightColor,
              validator: (value) {
                if (state is AuthenticationFailureState) {
                  if (state.exception ==
                      ListExceptionAuthentication.passwordInvalid) {
                    return state.message;
                  }
                }
                if (value!.isEmpty) {
                  return LabelConstant.PASSWORD_MUST_NOT_EMPTY;
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: LabelConstant.PASSWORD,
                labelStyle: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(height: DimensionConstant.HEIGHT_0),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: DimensionConstant.HEIGHT_40),
            AppAuthenButton(
              press: _onFormSubmitted,
              text: LabelConstant.SIGN_IN,
            ),
            const SizedBox(height: DimensionConstant.HEIGHT_8),
            const ForgotPasswordTextButton(),
            const SizedBox(height: DimensionConstant.HEIGHT_28),
            const AuthenMethodTitle(
              title: LabelConstant.OR_SIGN_IN_USING,
              flex: DimensionConstant.FLEX_2,
            ),
            const SizedBox(height: DimensionConstant.HEIGHT_32),
            const AppAuthenWithMediaSocialButton(
              text: LabelConstant.FACEBOOK,
              color: FinalPracticeColor.blueDarkColor,
            ),
            const SizedBox(height: DimensionConstant.HEIGHT_32),
            const AuthenMethodTitle(
              title: LabelConstant.OR,
            ),
            const SizedBox(height: DimensionConstant.HEIGHT_32),
            const AppAuthenWithMediaSocialButton(
              text: LabelConstant.GOOGLE,
              color: FinalPracticeColor.orangeDarkColor,
            ),
            const SizedBox(height: DimensionConstant.HEIGHT_20),
            HaveAnAccountOrNot(
              text: LabelConstant.DO_NOT_HAVE_AN_ACCOUNT,
              textButton: LabelConstant.SIGN_UP,
              press: () {
                Navigator.pushNamed(context, '/sign_up');
              },
            ),
          ],
        ),
      );
}
