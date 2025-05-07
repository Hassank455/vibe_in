import 'package:json_annotation/json_annotation.dart';
part 'slider_model.g.dart';

@JsonSerializable()
class SliderModel {
  bool? status;
  int? code;
  String? message;
  @JsonKey(name: 'data')
  List<SliderData>? sliderData;

  SliderModel({this.status, this.code, this.message, this.sliderData});

  factory SliderModel.fromJson(Map<String, dynamic> json) =>
      _$SliderModelFromJson(json);
}

@JsonSerializable()
class SliderData {
  int? id;
  String? image;

  SliderData({this.id, this.image});

  factory SliderData.fromJson(Map<String, dynamic> json) =>
      _$SliderDataFromJson(json);
}
