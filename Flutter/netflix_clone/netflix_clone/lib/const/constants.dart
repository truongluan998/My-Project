// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/netflix_clone_color.dart';

class PathConstant {
  static const String LOGO_NETFLIX = 'assets/icons/logo.svg';
  static const String ICON_NETFLIX_APPBAR = 'assets/icons/netflix.png';
  static const String ICON_GOOGLE = 'assets/icons/icon_google.svg';

  static const String IMAGE_ADVERTISING_SCREEN_ONE =
      'assets/images/background_netflix_1.jpg';
  static const String IMAGE_ADVERTISING_SCREEN_TWO =
      'assets/images/background_netflix_2.jpg';
  static const String IMAGE_ADVERTISING_SCREEN_THREE =
      'assets/images/background_netflix_3.jpg';
  static const String IMAGE_ADVERTISING_SCREEN_FOUR =
      'assets/images/background_netflix_4.jpg';

  static const String URL_PRIVACY_NETFLIX =
      'https://help.netflix.com/legal/privacy?fbclid=IwAR0rfBgBROpiiVvce_U24D_5L63VWrD0HIYHLpcjQct2VoqMTGWy5sDd_TI';
  static const String URL_HELP_NETFLIX =
      'https://help.netflix.com/legal/privacy?fbclid=IwAR0rfBgBROpiiVvce_U24D_5L63VWrD0HIYHLpcjQct2VoqMTGWy5sDd_TI';
}

class LabelConstant {
  static const String TITLE_APP = 'Netflix Clone App';
  static const String ERROR = 'Error';
  static const String PRIVACY = 'PRIVACY';
  static const String SIGN_IN = 'Sign In';
  static const String HELP = 'HELP';
  static const String GET_STARTED = 'Start a Free Plan';
  static const String MY_LIST = 'My List';
  static const String INFO = 'Info';
  static const String PLAY = 'Play';
  static const String DOWNLOAD = 'Download';
  static const String PREVIEW = 'Preview';
  static const String EPISODES = 'Episodes & Info';
  static const String EMAIL = 'Email';
  static const String EMAIL_HINT = 'netflix@gmail.com';
  static const String LEARN_MORE = 'Learn more about our ';
  static const String FREE_PLAN = 'free plan.';
  static const String CHAT = 'CHAT';
  static const String CHAT_NOW = 'CHAT NOW';
  static const String CALL = 'CALL';
  static const String CALL_NOW = 'CALL NOW';
  static const String CANCEL = 'CANCEL';
  static const String PASSWORD = 'Password';
  static const String HINT_PASSWORD = 'Enter Password';
  static const String NEED_HELP = 'Need Help?';
  static const String LOGIN_WITH_GOOGLE = 'Login With Google';
  static const String LOGIN_WITH_FACEBOOK = 'Login With Facebook';
  static const String WELCOME = 'Welcome: ';
  static const String CREATE_ACCOUNT = 'Create Account';

  static const String INVALID_EMAIL = 'Invalid Email';
  static const String INVALID_PASSWORD = 'Invalid Password';
  static const String EMAIL_MUST_NOT_EMPTY = 'Email must not empty';
  static const String PASSWORD_MUST_NOT_EMPTY = 'Invalid Password';
  static const String INCORRECT_EMAIL_OR_PASSWORD =
      'Incorrect Email or Password.';
  static const String CLICK_BELOW = 'By clicking below you agree to our ';
  static const String TERMS_OF_USE = 'Terms of Use, Privacy Statement,';
  static const String OVER_18_YEARS_OLD = ' and that you are over 18.';
  static const String ALREADY_ACCOUNT = 'Looks like you have an account.'
      ' Finish signing in below to watch for free.';

  static const String CREATE_ACCOUNT_SUCCESSFULLY =
      'Create Account Successfully';
  static const String ENTER_A_PASSWORD = 'Enter a password';
  static const String CREATE_FREE_ACCOUNT =
      'Create a free account to start watching.';
  static const String REJECT_EMAIL =
      'Please do not email me Netflix special offers.';
  static const String ACCEPT_OVER_18_YEARS_OLD = 'I agree i am over 18';

  static const String EMAIL_IS_REQUIRED = 'Email is required';
  static const String PASSWORD_IS_REQUIRED = 'Password is required';
  static const String COULD_NOT_LAUNCH = 'Could not launch ';
  static const String NEW_TO_NETFLIX = 'New to Netflix? Sign up now';
  static const String CAPTCHA = 'Sign in protected by Google reCAPTCHA to'
      " ensure you you're not a bot. Learn more.";

  static const String FIND_HELP_ONLINE = 'Find Help Online';
  static const String SIGN_IN_WITH_GOOGLE = 'Sign in with Google';
  static const String SIGN_INTO_NETFLIX =
      'Sign in to Netflix with your saved password';
  static const String SAVE_NETFLIX_PASSWORD_IN_GOOGLE =
      'You save your Netflix password in your Google Account. You can always '
      'change or manage your saved passwords in your Google Account.';

  static const String CONTACT_TITLE = 'Contact\n Netflix Customer Services';
  static const String CONTACT_DESCRIPTION = "We'll connect the call for free"
      ' using your internet connection.';
  static const String CONNECT_TO_SUPPORT = 'Connect with a live support agent.';

  static const String ADVERTISING_SCREEN_ONE = 'Advertising Screen One';
  static const String CONTENT_ADVERTISING_SCREEN_ONE = 'Watch anywhere.'
      ' Cancel at any time.';
  static const String TITLE_ADVERTISING_SCREEN_ONE = 'Unlimited films,'
      ' TV programmes & more';

  static const String ADVERTISING_SCREEN_TWO = 'Advertising Screen Two';
  static const String CONTENT_ADVERTISING_SCREEN_TWO = 'Always have '
      'something to watch offline.';
  static const String TITLE_ADVERTISING_SCREEN_TWO =
      'Download and watch offline';

  static const String ADVERTISING_SCREEN_THREE = 'Advertising Screen Three';
  static const String CONTENT_ADVERTISING_SCREEN_THREE =
      'Join today, cancel at any time.';
  static const String TITLE_ADVERTISING_SCREEN_THREE = 'No annoying contracts';

  static const String ADVERTISING_SCREEN_FOUR = 'Advertising Screen Four';
  static const String CONTENT_ADVERTISING_SCREEN_FOUR =
      'Stream on your phone, tablet, laptop, TV and more.';
  static const String TITLE_ADVERTISING_SCREEN_FOUR = 'Watch everywhere';
}

class DimensionConstant {
  static const double PADDING_4 = 4;
  static const double PADDING_6 = 6;
  static const double PADDING_8 = 8;
  static const double PADDING_10 = 10;
  static const double PADDING_12 = 12;
  static const double PADDING_16 = 16;
  static const double PADDING_24 = 24;
  static const double PADDING_32 = 32;
  static const double PADDING_40 = 40;
  static const double PADDING_52 = 52;
  static const double PADDING_56 = 56;
  static const double PADDING_84 = 84;

  static const int OFF_SET_0 = 0;
  static const int OFF_SET_1 = 1;
  static const int OFF_SET_2 = 2;

  static const double FONT_SIZE_11 = 11;
  static const double FONT_SIZE_12 = 12;
  static const double FONT_SIZE_14 = 14;
  static const double FONT_SIZE_15 = 15;
  static const double FONT_SIZE_16 = 16;
  static const double FONT_SIZE_17 = 17;

  static const double SIZE_10 = 10;
  static const double SIZE_24 = 24;
  static const double SIZE_28 = 28;
  static const double SIZE_36 = 36;

  static const double WIDTH_2 = 2;
  static const double WIDTH_4 = 4;
  static const double WIDTH_8 = 8;
  static const double WIDTH_12 = 12;
  static const double WIDTH_32 = 32;
  static const double WIDTH_92 = 92;
  static const double WIDTH_200 = 200;
  static const double WIDTH_250 = 200;
  static const double WIDTH_30_PERCENT = 0.3;

  static const double HEIGHT_1 = 1;
  static const double HEIGHT_2 = 2;
  static const double HEIGHT_4 = 4;
  static const double HEIGHT_8 = 8;
  static const double HEIGHT_12 = 12;
  static const double HEIGHT_16 = 16;
  static const double HEIGHT_24 = 24;
  static const double HEIGHT_32 = 32;
  static const double HEIGHT_36 = 36;
  static const double HEIGHT_48 = 48;
  static const double HEIGHT_132 = 132;
  static const double HEIGHT_200 = 200;
  static const double HEIGHT_14_PERCENT = 0.14;
  static const double HEIGHT_15_PERCENT = 0.15;
  static const double HEIGHT_8_DOT_5_PERCENT = 0.085;
  static const double HEIGHT_3_PERCENT = 0.03;
  static const double HEIGHT_1200 = 1200;

  static const double HEIGHT_OF_IMAGE_BACKGROUND_HOME = 0.72;
  static const double HEIGHT_OF_BOTTOM_SHEET_OVERVIEW_FILM = 0.36;
  static const double HEIGHT_OF_BOTTOM_SHEET_OVERVIEW_FILM_38 = 0.38;
  static const double HEIGHT_OF_BOTTOM_SHEET_LOGIN_WITH_GOOGLE_ACCOUNT = 0.35;
  static const double HEIGHT_OF_BOTTOM_SHEET_LOGIN_WITH_GOOGLE_ACCOUNT_40 =
      0.40;

  static const double ELEVATION_0 = 0;

  static const double BORDER_RADIUS_4 = 4;
  static const double BORDER_RADIUS_8 = 8;
  static const double BORDER_RADIUS_16 = 16;
  static const double BORDER_RADIUS_20 = 20;

  static const int DURATION_3S = 3;
  static const int DURATION_700_MILLISECONDS = 700;

  static const int MAX_LINES_2 = 2;
  static const int MAX_LINES_4 = 4;

  static const double POSITIONED_MINUS_9 = -9;
  static const double POSITIONED_0 = 0;
  static const double POSITIONED_60 = 60;
  static const double POSITIONED_90 = 90;
  static const double POSITIONED_120 = 120;

  static const double MAX_HEIGHT_0_DOT_38 = 0.38;
}

Future<void> openURL(String urlItem) async {
  final url = urlItem;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    final error = ArgumentError('${LabelConstant.COULD_NOT_LAUNCH} $urlItem');
    throw error;
  }
}

Future<void> showToast(String message) async {
  await Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
  );
}

InputDecoration inputDecorationTextFormFieldAuthenDark(
  BuildContext context,
  String? labelText,
  String hintText,
) =>
    InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: NetflixCloneColor.brownLightColor,
      filled: true,
      labelText: labelText,
      hintText: hintText,
      labelStyle:
          Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
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
    );

InputDecoration inputDecorationTextFormFieldAuthenLight(
  BuildContext context,
  String labelText,
  String hintText,
) =>
    InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      filled: true,
      labelText: labelText,
      hintText: hintText,
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
    );
