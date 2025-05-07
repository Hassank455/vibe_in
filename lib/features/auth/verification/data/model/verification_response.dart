import 'package:json_annotation/json_annotation.dart';
part 'verification_response.g.dart';

@JsonSerializable()
class VerificationResponse {
  Data? data;
  String? message;
  bool? status;
  int? code;

  VerificationResponse({this.data, this.message, this.status, this.code});
  factory VerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$VerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationResponseToJson(this);
}

@JsonSerializable()
class Data {
  String? token;
  User? user;

  Data({this.token, this.user});
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class User {
  int? id;
  String? name;
  String? phone;
  String? avatar;

  User({this.id, this.name, this.phone, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
