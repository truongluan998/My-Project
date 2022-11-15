import 'package:json_annotation/json_annotation.dart';
part 'categories.g.dart';

@JsonSerializable()
class CategoriesResponse {
  CategoriesResponse({
    this.data,
  });

  List<DataResponse>? data;

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => _$CategoriesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  DataResponse({
    this.deviceName,
    this.rate,
    this.price,
    this.url,
  });

  final String? deviceName;
  final double? rate;
  final String? price;
  final String? url;

  factory DataResponse.fromJson(Map<String, dynamic> json) => _$DataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}
