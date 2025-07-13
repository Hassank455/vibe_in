import 'package:json_annotation/json_annotation.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/models/category_model.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  int? id;
  String? name;
  String? description;
  String? label;
  List<String>? images;
  CategoryModel? category;
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

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
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

  Map<String, dynamic> toJson() => _$PricesModelToJson(this);
}
