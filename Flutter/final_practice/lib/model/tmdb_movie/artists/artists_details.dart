class ArtistsDetails {
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  String? birthday;
  dynamic deathday;
  int? gender;
  dynamic homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;

  ArtistsDetails({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  ArtistsDetails.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    alsoKnownAs =
        (json['also_known_as'] as List?)?.map((e) => e as String).toList();
    biography = json['biography'] as String?;
    birthday = json['birthday'] as String?;
    deathday = json['deathday'];
    gender = json['gender'] as int?;
    homepage = json['homepage'];
    id = json['id'] as int?;
    imdbId = json['imdb_id'] as String?;
    knownForDepartment = json['known_for_department'] as String?;
    name = json['name'] as String?;
    placeOfBirth = json['place_of_birth'] as String?;
    popularity = json['popularity'] as double?;
    profilePath = json['profile_path'] as String?;
  }
}
