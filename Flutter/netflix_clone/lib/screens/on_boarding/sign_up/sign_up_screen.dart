import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication_bloc/sign_up/check_email_exits/check_email_exits_bloc.dart';
import '../../../blocs/authentication_bloc/sign_up/sign_up_account/sign_up_bloc.dart';
import '../../../config/size_config.dart';
import '../../../const/constants.dart';
import '../../../theme/netflix_clone_color.dart';
import '../../../widgets/general/app_button.dart';
import '../../../widgets/general/app_circular_progress_indicator.dart';
import '../../../widgets/general/leading_netflix_icon_in_appbar.dart';
import '../../../widgets/onboarding_screen/appbar_text.dart';
import '../../../widgets/onboarding_screen/authentication/custom_text_normal_size.dart';
import '../../../widgets/onboarding_screen/authentication/text_rich_privacy_sign_up.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/sign_up_account';

  static Route route() => MaterialPageRoute(
        builder: (_) => const SignUpScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  late final CheckEmailExitsBloc _checkEmailExitsBloc;
  late final SignUpBloc _signUpBloc;

  final GlobalKey<FormState> _formKeySignUp = GlobalKey<FormState>();

  var _isCheckedSpecialOffers = false;
  var _isCheckedOver18 = true;
  late bool _passwordVisible;

  @override
  void initState() {
    _email = TextEditingController();
    _email.addListener(_onEmailChange);
    _password = TextEditingController();
    _password.addListener(_onPasswordChange);
    _checkEmailExitsBloc = BlocProvider.of<CheckEmailExitsBloc>(context);
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
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
    _signUpBloc.add(SignUpEmailChange(email: _email.text));
  }

  void _onPasswordChange() {
    _signUpBloc.add(SignUpPasswordChange(password: _password.text));
  }

  void _onFormSubmitted() {
    if (_formKeySignUp.currentState!.validate()) {
      _signUpBloc.add(
        SignUpWithCredentialsPressed(
          email: _email.text,
          password: _password.text,
        ),
      );
    }
  }

  Color _getColorCheckBox(Set<MaterialState> states) {
    const interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        bloc: _checkEmailExitsBloc,
        builder: (context, state) {
          if (state is EmailDoesNotExists) {
            _email.text = state.email;
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: const LeadingNetflixIconInAppBar(),
              actions: [
                AppBarText(
                  text: LabelConstant.PRIVACY,
                  press: () => openURL(PathConstant.URL_PRIVACY_NETFLIX),
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
            body: BlocConsumer<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state.isFailure) {
                  showToast(LabelConstant.INCORRECT_EMAIL_OR_PASSWORD);
                }
                if (state.isSuccess) {
                  Navigator.pushReplacementNamed(context, '/sign_in');
                  showToast(LabelConstant.CREATE_ACCOUNT_SUCCESSFULLY);
                }
              },
              builder: (context, state) {
                if (state.isSubmitting) {
                  return const Center(
                    child: AppCircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(
                    left: DimensionConstant.PADDING_24,
                    right: DimensionConstant.PADDING_24,
                    top: SizeConfig.screenHeight *
                        DimensionConstant.HEIGHT_15_PERCENT,
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LabelConstant.ENTER_A_PASSWORD,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const SizedBox(
                            height: DimensionConstant.HEIGHT_12,
                          ),
                          const CustomTextNormalSize(
                            text: LabelConstant.CREATE_FREE_ACCOUNT,
                          ),
                          const SizedBox(
                            height: DimensionConstant.HEIGHT_32,
                          ),
                          _formSignUp(context, state),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      );

  Form _formSignUp(BuildContext context, SignUpState state) => Form(
        key: _formKeySignUp,
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
              cursorColor: Colors.black,
              obscureText: !_passwordVisible,
              keyboardType: TextInputType.emailAddress,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.black87,
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
                fillColor: Colors.white,
                filled: true,
                labelText: LabelConstant.PASSWORD,
                hintText: LabelConstant.PASSWORD,
                labelStyle: Theme.of(context).textTheme.subtitle1,
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
                    color: NetflixCloneColor.brownColor,
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
              height: DimensionConstant.HEIGHT_24,
            ),
            Row(
              children: [
                SizedBox(
                  width: DimensionConstant.SIZE_24,
                  height: DimensionConstant.SIZE_36,
                  child: Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(
                      _getColorCheckBox,
                    ),
                    value: _isCheckedSpecialOffers,
                    onChanged: (_) {
                      setState(() {
                        _isCheckedSpecialOffers = !_isCheckedSpecialOffers;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: DimensionConstant.WIDTH_8,
                ),
                const Expanded(
                  child: CustomTextNormalSize(
                    text: LabelConstant.REJECT_EMAIL,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: DimensionConstant.HEIGHT_24,
            ),
            const Divider(
              height: DimensionConstant.HEIGHT_1,
              color: NetflixCloneColor.brownColor,
            ),
            const SizedBox(
              height: DimensionConstant.HEIGHT_24,
            ),
            const TextRichPrivacySignUp(),
            const SizedBox(
              height: DimensionConstant.HEIGHT_16,
            ),
            FormField(
              builder: (state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: DimensionConstant.SIZE_24,
                        height: DimensionConstant.SIZE_36,
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(
                            _getColorCheckBox,
                          ),
                          value: _isCheckedOver18,
                          onChanged: (value) {
                            setState(() {
                              _isCheckedOver18 = value!;
                              state.didChange(value);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: DimensionConstant.WIDTH_8,
                      ),
                      const Expanded(
                        child: CustomTextNormalSize(
                          text: LabelConstant.ACCEPT_OVER_18_YEARS_OLD,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !_isCheckedOver18,
                    child: Text(
                      state.errorText ?? 'You need to accept terms',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: DimensionConstant.FONT_SIZE_14,
                      ),
                    ),
                  )
                ],
              ),
              validator: (value) {
                if (!_isCheckedOver18) {
                  return 'You need to accept terms';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: DimensionConstant.HEIGHT_16,
            ),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                press: _onFormSubmitted,
                text: LabelConstant.CREATE_ACCOUNT,
              ),
            ),
            const SizedBox(
              height: DimensionConstant.HEIGHT_24,
            ),
          ],
        ),
      );
}
