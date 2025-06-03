import 'package:json_annotation/json_annotation.dart';
part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  bool? status;
  int? code;
  String? message;
  @JsonKey(name: 'data')
  ProfileData? profileData;

  ProfileModel({this.status, this.code, this.message, this.profileData});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

@JsonSerializable()
class ProfileData {
  int? id;
  String? name;
  String? phone;
  String? avatar;

  ProfileData({this.id, this.name, this.phone, this.avatar});

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);
}
