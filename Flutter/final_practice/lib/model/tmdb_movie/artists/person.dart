class Person {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  Person({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  Person.fromJson(Map<String, dynamic> json) {
    page = json['page'] as int?;
    results = (json['results'] as List?)
        ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
        .toList() ??  (json['cast'] as List?)
        ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
        .toList();
    totalPages = json['total_pages'] as int?;
    totalResults = json['total_results'] as int?;
  }
  //
  // factory  Person.fromJson(Map<String, dynamic> json) => Person({
  // page: json['page'],
  // results:  (json['results'] as List?)
  //     ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
  //     .toList() ??  (json['cast'] as List?)
  //     ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
  //     .toList();
  // totalPages = json['total_pages'] as int?;
  // totalResults = json['total_results'] as int?;
  // });
}

class Results {
  bool? adult;
  int? gender;
  int? id;
  List<KnownFor>? knownFor;
  String? knownForDepartment;
  String? name;
  double? popularity;
  String? profilePath;

  Results({
    this.adult,
    this.gender,
    this.id,
    this.knownFor,
    this.knownForDepartment,
    this.name,
    this.popularity,
    this.profilePath,
  });

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    gender = json['gender'] as int?;
    id = json['id'] as int?;
    knownFor = (json['known_for'] as List?)
        ?.map((e) => KnownFor.fromJson(e as Map<String, dynamic>))
        .toList();
    knownForDepartment = json['known_for_department'] as String?;
    name = json['name'] as String?;
    popularity = json['popularity'] as double?;
    profilePath = json['profile_path'] as String?;
  }
}

class KnownFor {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? mediaType;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  KnownFor({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.mediaType,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  KnownFor.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    backdropPath = json['backdrop_path'] as String?;
    genreIds =
        (json['genre_ids'] as List?)?.map((e) => e as int).toList();
    id = json['id'] as int?;
    mediaType = json['media_type'] as String?;
    originalLanguage = json['original_language'] as String?;
    originalTitle = json['original_title'] as String?;
    overview = json['overview'] as String?;
    posterPath = json['poster_path'] as String?;
    releaseDate = json['release_date'] as String?;
    title = json['title'] as String?;
    video = json['video'] as bool?;
    voteAverage = json['vote_average'] is int
        ? (json['vote_average'] as int).toDouble()
        : json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
  }
}
