import 'package:flutter/material.dart';

class ForgotPasswordTextButton extends StatelessWidget {
  const ForgotPasswordTextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () {},
    child: Text(
      'Forgot Password?',
      style: Theme.of(context).textTheme.subtitle2,
    ),
  );
}
