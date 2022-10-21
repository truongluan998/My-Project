import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utility.dart';
import 'validators.dart';

class UtilityDependencies {
  static Injector initialise(Injector injector) {
    injector
        .map<Utils>((injector) => Utils())
        .map<Validators>((injector) => Validators())
        .map<Future<SharedPreferences>>(
          (injector) => SharedPreferences.getInstance(),
        );
    return injector;
  }
}
