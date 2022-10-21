import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication_bloc/sign_in/sign_in_bloc.dart';
import '../../../blocs/authentication_bloc/sign_up/check_email_exits/check_email_exits_bloc.dart';
import '../../../const/constants.dart';
import '../../../theme/netflix_clone_color.dart';
import '../../../widgets/general/app_button.dart';
import '../../../widgets/general/app_circular_progress_indicator.dart';
import '../../../widgets/general/leading_netflix_icon_in_appbar.dart';
import '../../../widgets/onboarding_screen/appbar_text.dart';
import '../../../widgets/onboarding_screen/authentication/need_help_text_button.dart';

class SignInAlreadyHaveEmailScreen extends StatefulWidget {
  const SignInAlreadyHaveEmailScreen({Key? key}) : super(key: key);

  static const String routeName = '/sign_in_already_email';

  static Route route() => MaterialPageRoute(
        builder: (_) => const SignInAlreadyHaveEmailScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<SignInAlreadyHaveEmailScreen> createState() =>
      _SignInAlreadyHaveEmailScreenState();
}

class _SignInAlreadyHaveEmailScreenState
    extends State<SignInAlreadyHaveEmailScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  late bool _passwordVisible;

  late final CheckEmailExitsBloc _checkEmailExitsBloc;
  late final SignInBloc _signInBloc;

  final GlobalKey<FormState> _formKeySignIn = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _email.addListener(_onEmailChange);
    _password = TextEditingController();
    _password.addListener(_onPasswordChange);
    _checkEmailExitsBloc = BlocProvider.of<CheckEmailExitsBloc>(context);
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _passwordVisible = false;
    super.initState();
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
  Widget build(BuildContext context) => BlocBuilder(
        bloc: _checkEmailExitsBloc,
        builder: (context, state) {
          if (state is EmailAlreadyExists) {
            _email.text = state.email;
          }
          return Scaffold(
            appBar: AppBar(
              leading: const LeadingNetflixIconInAppBar(),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AppBarText(
                    text: LabelConstant.HELP,
                    press: () {
                      Navigator.pushNamed(context, '/help');
                    },
                  ),
                ),
              ],
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            LabelConstant.ALREADY_ACCOUNT,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: DimensionConstant.FONT_SIZE_16,
                            ),
                          ),
                          const SizedBox(
                            height: DimensionConstant.HEIGHT_32,
                          ),
                          _formSignInAlreadyHaveAccount(context, state),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );

  Form _formSignInAlreadyHaveAccount(BuildContext context, SignInState state) =>
      Form(
        key: _formKeySignIn,
        child: Column(
          children: [
            AbsorbPointer(
              child: TextFormField(
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
            const SizedBox(
              height: DimensionConstant.HEIGHT_16,
            ),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                press: _onFormSubmitted,
                text: LabelConstant.SIGN_IN,
              ),
            ),
            const SizedBox(
              height: DimensionConstant.HEIGHT_16,
            ),
            const NeedHelpTextButton(),
            const SizedBox(
              height: DimensionConstant.HEIGHT_16,
            ),
          ],
        ),
      );
}
