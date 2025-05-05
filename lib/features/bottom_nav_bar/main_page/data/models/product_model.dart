import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  int? id;
  String? name;
  String? description;
  String? label;
  List<String>? images;
  Category? category;
  List<PricesModel>? prices;
  Brand? brand;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.label,
    this.images,
    this.category,
    this.prices,
    this.brand,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

@JsonSerializable()
class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@JsonSerializable()
class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}

@JsonSerializable()
class PricesModel {
  int? id;
  String? weight;
  String? price;
  String? quantity;

  PricesModel({this.id, this.weight, this.price, this.quantity});

  factory PricesModel.fromJson(Map<String, dynamic> json) =>
      _$PricesModelFromJson(json);
}
