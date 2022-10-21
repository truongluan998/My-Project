class Genre {
  List<Genres>? genres;

  Genre({
    this.genres,
  });

  Genre.fromJson(Map<String, dynamic> json) {
    genres = (json['genres'] as List?)
        ?.map((e) => Genres.fromJson(e as Map<String, dynamic>))
        .toList();
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
