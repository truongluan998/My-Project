import 'dart:convert';

class AuthenticationDetail {
  const AuthenticationDetail({
    required this.isValid,
    this.uid,
    this.photoUrl,
    this.email,
    this.fullName,
  });

  final String? uid;
  final bool? isValid;
  final String? photoUrl;
  final String? email;
  final String? fullName;

  AuthenticationDetail copyWith({
    bool? isValid,
    String? uid,
    String? photoUrl,
    String? email,
    String? fullName,
  }) =>
      AuthenticationDetail(
        isValid: isValid ?? this.isValid,
        uid: uid ?? this.uid,
        photoUrl: photoUrl ?? this.photoUrl,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
      );

  Map<String, dynamic> toMap() => {
        'isValid': isValid,
        'uid': uid,
        'photoUrl': photoUrl,
        'email': email,
        'fullName': fullName
      };

  factory AuthenticationDetail.fromMap(Map<String, dynamic>? map) =>
      AuthenticationDetail(
        isValid: map?['isValid'],
        uid: map?['uid'],
        photoUrl: map?['photoUrl'],
        email: map?['email'],
        fullName: map?['fullName'],
      );

  String toJson() => json.encode(toMap());

  factory AuthenticationDetail.fromJson(String source) =>
      AuthenticationDetail.fromJson(json.decode(source));

  @override
  String toString() =>
      'AuthenticationDetail(isValid: $isValid, uid: $uid, photoUrl: $photoUrl, email: $email, fullName: $fullName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is AuthenticationDetail &&
        o.isValid == isValid &&
        o.uid == uid &&
        o.photoUrl == photoUrl &&
        o.email == email &&
        o.fullName == fullName;
  }

  @override
  int get hashCode =>
      isValid.hashCode ^
      uid.hashCode ^
      photoUrl.hashCode ^
      email.hashCode ^
      fullName.hashCode;
}
