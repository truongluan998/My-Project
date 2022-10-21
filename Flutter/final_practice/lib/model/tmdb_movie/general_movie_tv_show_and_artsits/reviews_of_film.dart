class ReviewsOfFilm {
  int? id;
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  ReviewsOfFilm({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  ReviewsOfFilm.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    page = json['page'] as int?;
    results = (json['results'] as List?)
        ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
        .toList();
    totalPages = json['total_pages'] as int?;
    totalResults = json['total_results'] as int?;
  }
}

class Results {
  String? author;
  AuthorDetails? authorDetails;
  String? content;
  String? createdAt;
  String? id;
  String? updatedAt;
  String? url;

  Results({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  Results.fromJson(Map<String, dynamic> json) {
    author = json['author'] as String?;
    authorDetails = (json['author_details'] as Map<String, dynamic>?) != null
        ? AuthorDetails.fromJson(json['author_details'] as Map<String, dynamic>)
        : null;
    content = json['content'] as String?;
    createdAt = json['created_at'] as String?;
    id = json['id'] as String?;
    updatedAt = json['updated_at'] as String?;
    url = json['url'] as String?;
  }
}

class AuthorDetails {
  String? name;
  String? username;
  String? avatarPath;
  double? rating;

  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  AuthorDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    username = json['username'] as String?;
    avatarPath = json['avatar_path'] as String?;
    rating = json['rating'] is int
        ? (json['rating'] as int).toDouble()
        : json['rating'] as double?;
  }
}
