import 'package:doctor_app/screens/auth/component/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';

class SignInForm extends StatelessWidget {
  SignInForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;
  late final String _password, _email;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFieldName(
            text: 'Email',
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'Email'),
            validator: RequiredValidator(errorText: "Email is required"),
            onSaved: (email) => _email = email!,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          TextFieldName(
            text: 'Password',
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(hintText: '**********'),
            validator: passwordValidator,
            onSaved: (password) => _password = password!,
            onChanged: (pass) => _password = pass,
          ),
        ]));
  }
}
