import 'package:json_annotation/json_annotation.dart';
part 'slider_model.g.dart';

@JsonSerializable()
class SliderModel {
  int? id;
  String? image;

  SliderModel({this.id, this.image});

  factory SliderModel.fromJson(Map<String, dynamic> json) =>
      _$SliderModelFromJson(json);
}
