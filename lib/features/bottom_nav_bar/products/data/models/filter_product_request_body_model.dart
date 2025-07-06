import 'package:json_annotation/json_annotation.dart';
part 'filter_product_request_body_model.g.dart';

@JsonSerializable()
class FilterProductRequestBodyModel {
  @JsonKey(name: "per_page")
  int? perPage;
  int? page;
  @JsonKey(name: "category_id")
  List<int>? catIds;
  String? search;

  FilterProductRequestBodyModel({
    this.perPage,
    this.page,
    this.catIds,
    this.search,
  });

  Map<String, dynamic> toJson() => _$FilterProductRequestBodyModelToJson(this);
}
