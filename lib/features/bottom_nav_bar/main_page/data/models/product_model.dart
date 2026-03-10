import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/models/category_model.dart';
part 'product_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ProductModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? label;
  @HiveField(4)
  List<String>? images;
  @HiveField(5)
  CategoryModel? category;
  @HiveField(6)
  List<PricesModel>? prices;
  @HiveField(7)
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

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    String? label,
    List<String>? images,
    CategoryModel? category,
    List<PricesModel>? prices,
    Brand? brand,
  }) => ProductModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    label: label ?? this.label,
    images: images ?? this.images,
    category: category ?? this.category,
    prices: prices ?? this.prices,
    brand: brand ?? this.brand,
  );
}

@HiveType(typeId: 2)
@JsonSerializable()
class Brand {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  Brand({this.id, this.name});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class PricesModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? weight;
  @HiveField(2)
  String? price;
  @HiveField(3)
  String? quantity;

  PricesModel({this.id, this.weight, this.price, this.quantity});

  factory PricesModel.fromJson(Map<String, dynamic> json) =>
      _$PricesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PricesModelToJson(this);
}
