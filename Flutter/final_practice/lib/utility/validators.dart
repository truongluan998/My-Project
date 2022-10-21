class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  static final RegExp _fullNameRegExp = RegExp(
    r'^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}$',
  );

  bool isValidFullName(String fullName) => _fullNameRegExp.hasMatch(fullName);

  bool isValidEmail(String email) => _emailRegExp.hasMatch(email);

  bool isValidPassword(String password) => _passwordRegExp.hasMatch(password);
}


