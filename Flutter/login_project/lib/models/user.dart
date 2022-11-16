import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? email;
  final String? password;
  final String? accessToken;

  User(
    this.id,
    this.email,
    this.password,
    this.accessToken,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
