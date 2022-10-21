class FilmDetails {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genres>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  FilmDetails({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  FilmDetails.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    backdropPath = json['backdrop_path'] as String?;
    belongsToCollection =
        (json['belongs_to_collection'] as Map<String, dynamic>?) != null
            ? BelongsToCollection.fromJson(
                json['belongs_to_collection'] as Map<String, dynamic>,
              )
            : null;
    budget = json['budget'] as int?;
    genres = (json['genres'] as List?)
        ?.map((e) => Genres.fromJson(e as Map<String, dynamic>))
        .toList();
    homepage = json['homepage'] as String?;
    id = json['id'] as int?;
    imdbId = json['imdb_id'] as String?;
    originalLanguage = json['original_language'] as String?;
    originalTitle = json['original_title'] as String?;
    overview = json['overview'] as String?;
    popularity = json['popularity'] as double?;
    posterPath = json['poster_path'] as String?;
    productionCompanies = (json['production_companies'] as List?)
        ?.map(
          (e) => ProductionCompanies.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    productionCountries = (json['production_countries'] as List?)
        ?.map(
          (e) => ProductionCountries.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    releaseDate = json['release_date'] as String?;
    revenue = json['revenue'] as int?;
    runtime = json['runtime'] as int?;
    spokenLanguages = (json['spoken_languages'] as List?)
        ?.map(
          (e) => SpokenLanguages.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    status = json['status'] as String?;
    tagline = json['tagline'] as String?;
    title = json['title'] as String?;
    video = json['video'] as bool?;
    voteAverage = json['vote_average'] is int
        ? (json['vote_average'] as int).toDouble()
        : json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
  }
}

class BelongsToCollection {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    posterPath = json['poster_path'] as String?;
    backdropPath = json['backdrop_path'] as String?;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({
    this.id,
    this.name,
  });

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
  }
}

class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    logoPath = json['logo_path'] as String?;
    name = json['name'] as String?;
    originCountry = json['origin_country'] as String?;
  }
}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({
    this.iso31661,
    this.name,
  });

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'] as String?;
    name = json['name'] as String?;
  }
}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({
    this.englishName,
    this.iso6391,
    this.name,
  });

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'] as String?;
    iso6391 = json['iso_639_1'] as String?;
    name = json['name'] as String?;
  }
}
