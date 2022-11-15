import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../config/size_config.dart';
import '../config/theme_config.dart';

class Utils {
  static Future<void> showToast(String message) async {
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void setConfigApp(BuildContext context) {
    SizeConfig().init(context);
    ThemeConfig().init(context);
  }
}