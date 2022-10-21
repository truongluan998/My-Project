import 'package:flutter/material.dart';
import '../../const/constants.dart';
import '../../theme/netflix_clone_color.dart';

class CustomTextFormFieldAuthentication extends StatelessWidget {
  const CustomTextFormFieldAuthentication({
    required this.textController,
    required this.hint,
    required this.label,
    this.isPasswordField = false,
    Key? key,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final String label;
  final bool isPasswordField;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: textController,
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        obscureText: isPasswordField,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: NetflixCloneColor.textWhiteColor,
              fontSize: DimensionConstant.FONT_SIZE_16,
            ),
        validator: (value) => (value!.isEmpty)
            ? isPasswordField
                ? LabelConstant.PASSWORD_IS_REQUIRED
                : LabelConstant.EMAIL_IS_REQUIRED
            : null,
        onSaved: (value) => value = textController.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: NetflixCloneColor.brownLightColor,
          filled: true,
          labelText: label,
          hintText: hint,
          labelStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white),
          hintStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white),
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
        ),
      );
}
