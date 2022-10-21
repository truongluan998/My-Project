class ImagesOfArtists {
  int? id;
  List<Profiles>? profiles;

  ImagesOfArtists({
    this.id,
    this.profiles,
  });

  ImagesOfArtists.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    profiles = (json['profiles'] as List?)
        ?.map((e) => Profiles.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class Profiles {
  double? aspectRatio;
  int? height;
  dynamic iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Profiles({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  Profiles.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'] as double?;
    height = json['height'] as int?;
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'] as String?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
    width = json['width'] as int?;
  }
}
