import 'package:json_annotation/json_annotation.dart';
part 'onboarding_model.g.dart';

@JsonSerializable()
class OnboardingModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  OnboardingModel({this.status, this.code, this.message, this.data});

  factory OnboardingModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingModelFromJson(json);
}

@JsonSerializable()
class Data {
  int? id;
  String? title;
  String? description;
  String? image;

  Data({this.id, this.title, this.description, this.image});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
