// ignore_for_file: constant_identifier_names

class PathConstant {
  static const String BACKGROUND_AUTHEN_SCREEN =
      'assets/images/background_authen.png';
  static const String BACKGROUND_GENRE = 'assets/images/background_genre_';

  static const String FACEBOOK_LIKED_ICON = 'assets/icons/facebook_liked.png';

  static const String IMAGE_DEFAULT_WHEN_LOAD_IMAGE_ERROR_1 =
      'assets/images/background_1.jpg';
  static const String IMAGE_DEFAULT_WHEN_LOAD_IMAGE_ERROR_2 =
      'assets/images/background_2.jpg';
  static const String IMAGE_DEFAULT_WHEN_LOAD_IMAGE_ERROR_3 =
      'assets/images/background_3.jpg';

  static const String DEFAULT_URL_IMAGE = 'https://image.tmdb.org/t/p/w500';
  static const String BASE_URL = 'https://api.themoviedb.org/3/';
  static const String API_KEY_MOVIE_DB = 'b5900555525b1d6cc2ce365165203250';

  static const String TRENDING_QUERY = 'trending/all/day?api_key=';
  static const String DISCOVER_TV_QUERY = 'discover/tv?api_key=';
  static const String DISCOVER_MOVIE_QUERY = 'discover/movie?api_key=';
  static const String RECENT_QUERY = 'tv/on_the_air?api_key=';
  static const String MOVIE_UPCOMING_QUERY = 'movie/upcoming?api_key=';
  static const String GENRE_QUERY = 'genre/movie/list?api_key=';
  static const String PERSON_QUERY = 'person/popular?api_key=';
  static const String SEARCH_MULTI_QUERY = 'search/multi?api_key=';

  static const String OPTION_QUERY = '&language=en-US';
  static const String OPTION_QUERY_AND_PAGE = '&language=en-US&page=';
  static const String OPTION_QUERY_PAGE_1 = '&language=en-US&page=1';
  static const String OPTION_QUERY_DISCOVER =
      '&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate';
  static const String OPTION_QUERY_DISCOVER_BEFORE =
      '&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=';
  static const String OPTION_QUERY_DISCOVER_AFTER =
      '&with_watch_monetization_types=flatrate';

  static const String OPTION_QUERY_SEARCH_GENRE_BEFORE =
      '&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=';
  static const String OPTION_QUERY_SEARCH_GENRE_PAGE = '&with_genres=';
  static const String OPTION_QUERY_SEARCH_GENRE_AFTER =
      '&with_watch_monetization_types=flatrate';

  static const OPTION_QUERY_SEARCH_MULTI_BEFORE = '&language=en-US&query=';
  static const OPTION_QUERY_SEARCH_MULTI_AFTER = '&page=1&include_adult=false';

  static const DETAILS_MOVIE_QUERY_BEFORE = 'movie/';
  static const DETAILS_TV_QUERY_BEFORE = 'tv/';
  static const DETAILS_QUERY_CREDIT = '/credits?api_key=';
  static const DETAILS_QUERY_REVIEWS = '/reviews?api_key=';
  static const DETAILS_QUERY_VIDEO = '/videos?api_key=';
  static const DETAILS_QUERY_AFTER = '?api_key=';

  static const DETAILS_ARTISTS_QUERY_BEFORE = 'person/';
  static const DETAILS_QUERY_IMAGE = '/images?api_key=';
}

class LabelConstant {
  static const String TITLE_APP = 'Final Practice';

  static const String NAME = 'Name';
  static const String EMAIL = 'Email';
  static const String PASSWORD = 'Password';
  static const String SIGN_UP = 'Sign Up';
  static const String SIGN_IN = 'Sign In';
  static const String OR_SIGN_IN_USING = 'or Sign In using';
  static const String FACEBOOK = 'Facebook';
  static const String OR = 'or';
  static const String GOOGLE = 'Google +';
  static const String ALREADY_HAVE_AN_ACCOUNT = 'Already have an Account?';
  static const String DO_NOT_HAVE_AN_ACCOUNT = "Don't have an Account?";
  static const String SOMETHING_WRONG = 'Something Wrong! Try again.';
  static const String SEE_ALL = 'See All';
  static const String NA = 'NA';

  static const String CREATE_ACCOUNT_FAIL = 'Create Account Fail';
  static const String CREATE_ACCOUNT_SUCCESSFULLY =
      'Create Account Successfully';
  static const String INVALID_FULL_NAME = 'Invalid FullName';
  static const String FULL_NAME_MUST_NOT_EMPTY = 'FullName must not empty';
  static const String INVALID_EMAIL = 'Invalid Email';
  static const String EMAIL_MUST_NOT_EMPTY = 'Email must not empty';
  static const String INVALID_PASSWORD = 'Invalid Password';
  static const String PASSWORD_MUST_NOT_EMPTY = 'Email must not empty';

  static const String WELCOME = 'Welcome ';
  static const String INCORRECT_EMAIL_OR_PASSWORD =
      'Incorrect Email Or Password.';

  static const String FIRST_ON_BOARDING = 'First OnBoarding';
  static const String SECOND_ON_BOARDING = 'Second OnBoarding';
  static const String THIRD_ON_BOARDING = 'Third OnBoarding';
  static const String EXPLORE_COLLECTION = 'Explore Collection';
  static const String MOVIE_AND_SERIES = 'Movies & Series';
  static const String CONTENT_MOVIE_AND_SERIES =
      'The world’s most popular and authoritative'
      ' source for overview_details and series.';

  static const String DISCOVER = 'Discover';
  static const String GENRES = 'Genres';
  static const String ARTISTS = 'Artists';
  static const String MOVIES = 'Movies';
  static const String TV_SHOW = 'TV Show';
  static const String CAST = 'Cast';
  static const String REVIEWS = 'Reviews';
  static const String SUMMARY = 'Summary';
  static const String MORE = 'More';

  static const String MOST_POPULAR = 'Most Popular';
  static const String COMING_SOON = 'Coming Soon';
  static const String MOST_RECENT = 'Most Recent';
  static const String CHECK_INTERNET =
      'Check Internet & click Here to refresh!';

  static const String ALL_MOVIE_POPULAR = 'All Movies Popular';
  static const String ALL_MOVIE_MOST_RECENT = 'All Movies Most Recent';
  static const String ALL_MOVIE_COMING_SOON = 'All Movies Coming Soon';
  static const String ALL_MOVIE = 'All Movies';
  static const String LOADING = 'Loading...';
  static const String CANCEL = 'Cancel';
  static const String SEARCH = 'Search';
  static const String SEARCH_FAIL =
      'Search Fail! Check Internet and Try Again.';
  static const String NO_DATA = 'No Data!';
  static const String FIVE = '5.0';
  static const String LANGUAGE = 'Language: ';
  static const String VIEW_ALL = ' ...view all';
  static const String VIEW_LESS = ' view less';
  static const String HELPFUL = '1500 helpful votes';
  static const String PHOTO_ALBUMS = 'Photo Albums';
}

class DimensionConstant {
  static const double DEFAULT_HEIGHT_APP_BAR = 56;

  static const double ELEVATION_0 = 0;

  static const double PADDING_2 = 2;
  static const double PADDING_4 = 4;
  static const double PADDING_6 = 6;
  static const double PADDING_8 = 8;
  static const double PADDING_12 = 12;
  static const double PADDING_16 = 16;
  static const double PADDING_20 = 20;
  static const double PADDING_36 = 36;
  static const double PADDING_40 = 40;

  static const double HEIGHT_0 = 0;
  static const double HEIGHT_0_DOT_06 = 0.06;
  static const double HEIGHT_0_DOT_15 = 0.15;
  static const double HEIGHT_0_DOT_25 = 0.25;
  static const double HEIGHT_0_DOT_35 = 0.35;
  static const double HEIGHT_0_DOT_36 = 0.36;
  static const double HEIGHT_0_DOT_40 = 0.40;
  static const double HEIGHT_0_DOT_45 = 0.45;
  static const double HEIGHT_0_DOT_5 = 0.5;
  static const double HEIGHT_0_DOT_8 = 0.8;
  static const double HEIGHT_2 = 2;
  static const double HEIGHT_4 = 4;
  static const double HEIGHT_6 = 6;
  static const double HEIGHT_8 = 8;
  static const double HEIGHT_16 = 16;
  static const double HEIGHT_20 = 20;
  static const double HEIGHT_24 = 24;
  static const double HEIGHT_28 = 28;
  static const double HEIGHT_32 = 32;
  static const double HEIGHT_40 = 40;
  static const double HEIGHT_48 = 48;
  static const double HEIGHT_60 = 60;
  static const double HEIGHT_180 = 180;
  static const double HEIGHT_204 = 204;
  static const double HEIGHT_210 = 210;
  static const double HEIGHT_250 = 250;
  static const double HEIGHT_280 = 280;
  static const double HEIGHT_290 = 290;
  static const double HEIGHT_320 = 320;

  static const double WIDTH_8 = 8;
  static const double WIDTH_12 = 12;
  static const double WIDTH_16 = 16;
  static const double WIDTH_24 = 24;
  static const double WIDTH_130 = 130;
  static const double WIDTH_139 = 139;
  static const double WIDTH_158 = 158;
  static const double WIDTH_0_DOT_3 = 0.3;


  static const double THICKNESS_2 = 2;

  static const double POSITIONED_48 = 48;

  static const double OPACITY_0_DOT_2 = 0.2;
  static const double OPACITY_0_DOT_3 = 0.3;
  static const double OPACITY_0_DOT_5 = 0.5;
  static const double OPACITY_0_DOT_6 = 0.6;
  static const double OPACITY_0_DOT_9 = 0.9;

  static const double OFF_SET_0 = 0;
  static const double OFF_SET_2 = 2;

  static const double BORDER_RADIUS_4 = 4;
  static const double BORDER_RADIUS_6 = 6;
  static const double BORDER_RADIUS_12 = 12;

  static const double FONT_SIZE_13 = 13;
  static const double FONT_SIZE_14 = 14;
  static const double FONT_SIZE_15 = 15;
  static const double FONT_SIZE_16 = 16;
  static const double FONT_SIZE_17 = 17;

  static const double SIZE_8 = 8;
  static const double SIZE_18 = 18;
  static const double SIZE_24 = 24;
  static const double SIZE_28 = 28;
  static const double SIZE_32 = 32;
  static const double SIZE_48 = 48;
  static const double SIZE_60 = 60;

  static const double CHILD_ASPECT_RATIO_0_DOT_47 = 0.47;
  static const double CHILD_ASPECT_RATIO_0_DOT_5 = 0.5;
  static const double CHILD_ASPECT_RATIO_0_DOT_74 = 0.74;
  static const double CROSS_AXIS_SPACING_8 = 8;
  static const double MAIN_AXIS_SPACING_8 = 8;

  static const int FLEX_2 = 2;
  static const int MAX_LINE_1 = 1;
  static const int MAX_LINE_2 = 2;
  static const int MAX_LINE_3 = 3;
  static const int PAGE_INDEX = 0;
  static const int CROSS_AXIS_COUNT_2 = 2;
  static const int CROSS_AXIS_COUNT_3 = 3;
}
