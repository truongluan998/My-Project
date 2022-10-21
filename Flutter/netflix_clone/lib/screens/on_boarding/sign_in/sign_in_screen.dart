import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../blocs/authentication_bloc/sign_in/sign_in_bloc.dart';
import '../../../config/size_config.dart';
import '../../../const/constants.dart';
import '../../../theme/netflix_clone_color.dart';
import '../../../widgets/general/app_circular_progress_indicator.dart';
import '../../../widgets/general/custom_text_details_small.dart';
import '../../../widgets/onboarding_screen/authentication/need_help_text_button.dart';

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
  late final SignInBloc _signInBloc;

  late bool _passwordVisible;

  final GlobalKey<FormState> _formKeySignIn = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _email.addListener(_onEmailChange);
    _password = TextEditingController();
    _password.addListener(_onPasswordChange);
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    _signInBloc.add(SignInEmailChange(email: _email.text));
  }

  void _onPasswordChange() {
    _signInBloc.add(SignInPasswordChange(password: _password.text));
  }

  void _onFormSubmitted() {
    if (_formKeySignIn.currentState!.validate()) {
      _signInBloc.add(
        SignInWithCredentialsPressed(
          email: _email.text,
          password: _password.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            PathConstant.LOGO_NETFLIX,
            height: DimensionConstant.SIZE_28,
            width: DimensionConstant.SIZE_28,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensionConstant.PADDING_24,
          ),
          child: BlocConsumer<SignInBloc, SignInState>(
            listener: (context, state) {
              if (state.isFailure) {
                showToast(LabelConstant.INCORRECT_EMAIL_OR_PASSWORD);
              }
              if (state.isSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
                showToast('${LabelConstant.WELCOME}${_email.text}');
              }
            },
            builder: (context, state) {
              if (state.isSubmitting) {
                return const Center(
                  child: AppCircularProgressIndicator(),
                );
              }
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _formSignIn(context, state),
                      SizedBox(
                        height: SizeConfig.screenHeight *
                            DimensionConstant.HEIGHT_3_PERCENT,
                      ),
                      const NeedHelpTextButton(),
                      const SizedBox(
                        height: DimensionConstant.HEIGHT_8,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/on_boarding');
                        },
                        child: const Text(
                          LabelConstant.NEW_TO_NETFLIX,
                          style: TextStyle(
                            fontSize: DimensionConstant.FONT_SIZE_16,
                            fontWeight: FontWeight.w600,
                            color: NetflixCloneColor.textWhiteDarkColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight *
                            DimensionConstant.HEIGHT_3_PERCENT,
                      ),
                      const Visibility(
                        child: CustomTextDetailsSmall(
                          text: LabelConstant.CAPTCHA,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight *
                            DimensionConstant.HEIGHT_3_PERCENT,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );

  Form _formSignIn(BuildContext context, SignInState state) => Form(
        key: _formKeySignIn,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _email,
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: NetflixCloneColor.textWhiteColor,
                    fontSize: DimensionConstant.FONT_SIZE_16,
                  ),
              validator: (value) => !state.isEmailValid
                  ? LabelConstant.INVALID_EMAIL
                  : value!.isEmpty
                      ? LabelConstant.EMAIL_MUST_NOT_EMPTY
                      : null,
              autocorrect: false,
              decoration: inputDecorationTextFormFieldAuthenDark(
                context,
                LabelConstant.EMAIL,
                LabelConstant.EMAIL_HINT,
              ),
            ),
            const SizedBox(
              height: DimensionConstant.HEIGHT_8,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _password,
              cursorColor: Colors.white,
              obscureText: !_passwordVisible,
              keyboardType: TextInputType.emailAddress,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: NetflixCloneColor.textWhiteColor,
                    fontSize: DimensionConstant.FONT_SIZE_16,
                  ),
              validator: (value) => !state.isPasswordValid
                  ? LabelConstant.INVALID_PASSWORD
                  : value!.isEmpty
                      ? LabelConstant.PASSWORD_MUST_NOT_EMPTY
                      : null,
              autocorrect: false,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: NetflixCloneColor.brownLightColor,
                filled: true,
                labelText: LabelConstant.PASSWORD,
                hintText: LabelConstant.PASSWORD,
                labelStyle: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white),
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    DimensionConstant.BORDER_RADIUS_4,
                  ),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    DimensionConstant.BORDER_RADIUS_4,
                  ),
                  borderSide: BorderSide.none,
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
            const SizedBox(
              height: DimensionConstant.HEIGHT_36,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(
                      DimensionConstant.PADDING_16,
                    ),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    NetflixCloneColor.textWhiteColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        DimensionConstant.BORDER_RADIUS_8,
                      ),
                      side: const BorderSide(
                        color: NetflixCloneColor.brownColor,
                        width: DimensionConstant.WIDTH_2,
                      ),
                    ),
                  ),
                ),
                onPressed: _onFormSubmitted,
                child: const Text(
                  LabelConstant.SIGN_IN,
                ),
              ),
            ),
          ],
        ),
      );
}
