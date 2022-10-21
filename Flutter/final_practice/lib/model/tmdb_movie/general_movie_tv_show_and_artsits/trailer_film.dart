class TrailerFilm {
  int? id;
  List<Results>? results;

  TrailerFilm({
    this.id,
    this.results,
  });

  TrailerFilm.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    results = (json['results'] as List?)
        ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class Results {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? publishedAt;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? id;

  Results({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.publishedAt,
    this.site,
    this.size,
    this.type,
    this.official,
    this.id,
  });

  Results.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'] as String?;
    iso31661 = json['iso_3166_1'] as String?;
    name = json['name'] as String?;
    key = json['key'] as String?;
    publishedAt = json['published_at'] as String?;
    site = json['site'] as String?;
    size = json['size'] as int?;
    type = json['type'] as String?;
    official = json['official'] as bool?;
    id = json['id'] as String?;
  }
}
