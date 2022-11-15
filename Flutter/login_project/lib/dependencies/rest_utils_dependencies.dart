import 'package:get_it/get_it.dart';

import '../utils/rest_utils.dart';

class RestUtilsDependencies {
  static GetIt initGetIt(GetIt getIt) {
    getIt.registerSingleton<RestUtils>(RestUtils());
    return getIt;
  }
}
