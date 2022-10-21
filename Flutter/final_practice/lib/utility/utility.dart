import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../dependencies/app_dependencies.dart';
import '../model/tmdb_movie/general_movie_tv_show_and_artsits/film_details.dart';
import '../model/tmdb_movie/general_movie_tv_show_and_artsits/tmdb_data.dart';

class Utils {
  BoxDecoration buildBackgroundAuthenScreen() => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            PathConstant.BACKGROUND_AUTHEN_SCREEN,
          ),
          fit: BoxFit.cover,
        ),
      );

  InputDecoration inputDecorationTextFormFieldAuthen(
    BuildContext context,
    String labelText,
  ) =>
      InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(height: DimensionConstant.HEIGHT_0),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white38),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white38),
        ),
      );

  Future<void> showToast(String message) async {
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  int randomItemInResultList(int? total) {
    final random = Random();
    if (total != null) {
      final randomPage = random.nextInt(total);
      return randomPage;
    } else {
      return 1;
    }
  }

  Future<void> setPrefsToOpenOnBoarding(String key, bool value) async {
    final prefs =
        await AppDependencies.injector.get<Future<SharedPreferences>>();
    await prefs.setBool(key, value);
  }

  Future<bool> getPrefsToOpenOnBoarding(String key) async {
    final prefs =
        await AppDependencies.injector.get<Future<SharedPreferences>>();
    return prefs.getBool(key) ?? false;
  }

  void filterResultsWhenSearch(
    TMDBData? modelTMDB,
    List<Results> listResult,
    String type,
  ) {
    if (modelTMDB != null) {
      for (var i = 0; i < modelTMDB.results!.length; i++) {
        if (modelTMDB.results![i].mediaType == type) {
          listResult.add(modelTMDB.results![i]);
        }
      }
    } else {
      return;
    }
  }

  String convertGenresData(List<Genres>? listGenres) {
    final listGenre = listGenres!
        .map(
          (genres) => genres.name,
    )
        .toList()
        .join(' | ');
    return listGenre;
  }

  String convertTime(String time) {
    final parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(time);
    final inputDate = DateTime.parse(parseDate.toString());
    final outputFormat = DateFormat.yMMMd();
    final outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
