import 'package:flutter/material.dart';

import '../screens/authen/sign_in_screen.dart';
import '../screens/authen/sign_up_screen.dart';
import '../screens/details/artists/gallery_images_of_artists.dart';
import '../screens/details/artists_details_screen.dart';
import '../screens/details/film_details_screen.dart';
import '../screens/details/tab_of_details_of_film/play_trailer.dart';
import '../screens/discorver/all_movies/coming_soon_screen.dart';
import '../screens/discorver/all_movies/most_popular_screen.dart';
import '../screens/discorver/all_movies/most_recent_screen.dart';
import '../screens/genres/movie_in_by_genre_screen.dart';
import '../screens/main_screen.dart';
import '../screens/on_boarding/on_boarding_screen.dart';
import '../screens/splash_screen.dart';

mixin AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return _createAnimationRoute(const SplashScreen(), settings);
      case SignInScreen.routeName:
        return _createAnimationRoute(const SignInScreen(), settings);
      case SignUpScreen.routeName:
        return _createAnimationRoute(const SignUpScreen(), settings);
      case OnBoardingScreen.routeName:
        return _createAnimationRoute(const OnBoardingScreen(), settings);
      case MainScreen.routeName:
        return _createAnimationRoute(const MainScreen(), settings);
      case MostPopularScreen.routeName:
        return _createAnimationRoute(const MostPopularScreen(), settings);
      case MostRecent.routeName:
        return _createAnimationRoute(const MostRecent(), settings);
      case ComingSoon.routeName:
        return _createAnimationRoute(const ComingSoon(), settings);
      case MovieInByGenreScreen.routeName:
        return _createAnimationRoute(const MovieInByGenreScreen(), settings);
      case FilmDetailsScreen.routeName:
        return _createAnimationRoute(const FilmDetailsScreen(), settings);
      case PlayTrailer.routeName:
        return _createAnimationRoute(const PlayTrailer(), settings);
      case ArtistsDetailScreen.routeName:
        return _createAnimationRoute(const ArtistsDetailScreen(), settings);
      case GalleryImageOfArtists.routeName:
        return _createAnimationRoute(const GalleryImageOfArtists(), settings);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text('Page Error'),
          ),
        ),
        settings: const RouteSettings(name: '/error'),
      );
}

Route _createAnimationRoute(Widget screen, RouteSettings settings) =>
    PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: 700,
      ),
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
