import 'package:flutter_config/flutter_config.dart';

class AppStrings{
  static String baseUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=${FlutterConfig.get('API_KEY')}&language=en-US&page=';
}