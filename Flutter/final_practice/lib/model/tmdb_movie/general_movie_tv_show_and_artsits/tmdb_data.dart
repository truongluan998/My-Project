enum MediaType { movie, tv }

class TMDBData {
  List<Results>? results;
  MediaType? type;

  TMDBData({
    this.results,
    this.type,
  });

  TMDBData.fromJson(Map<String, dynamic> json) {
    results = (json['results'] as List?)
        ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class Results {
  int? id;
  String? name;
  String? posterPath;
  List<int>? genreIds;
  List<String>? genreNames = [];
  String? mediaType;
  double? voteAverage;

  Results({
    this.id,
    this.name,
    this.posterPath,
    this.genreIds,
    this.genreNames,
    this.mediaType,
    this.voteAverage,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String? ?? json['title'] as String?;
    posterPath =
        json['poster_path'] as String? ?? json['profile_path'] as String?;
    genreIds = (json['genre_ids'] as List?)?.map((e) => e as int).toList();
    mediaType = json['media_type'] as String?;
    voteAverage = (json['vote_average'] is int
            ? (json['vote_average'] as int).toDouble()
            : json['vote_average'] as double?) ??
        (json['popularity'] is int
            ? (json['popularity'] as int).toDouble()
            : json['popularity'] as double?);
  }
}
