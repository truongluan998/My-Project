class TvShow {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  TvShow({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  TvShow.fromJson(Map<String, dynamic> json) {
    page = json['page'] as int?;
    results = (json['results'] as List?)
        ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
        .toList();
    totalPages = json['total_pages'] as int?;
    totalResults = json['total_results'] as int?;
  }
}

class Results {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  Results({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  Results.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'] as String?;
    firstAirDate = json['first_air_date'] as String?;
    genreIds = (json['genre_ids'] as List?)?.map((e) => e as int).toList();
    id = json['id'] as int?;
    name = json['name'] as String?;
    originCountry =
        (json['origin_country'] as List?)?.map((e) => e as String).toList();
    originalLanguage = json['original_language'] as String?;
    originalName = json['original_name'] as String?;
    overview = json['overview'] as String?;
    popularity = json['popularity'] is int
        ? (json['popularity'] as int).toDouble()
        : json['popularity'] as double?;
    posterPath = json['poster_path'] as String?;
    voteAverage = json['vote_average'] is int
        ? (json['vote_average'] as int).toDouble()
        : json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
  }

}
