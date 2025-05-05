// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  label: json['label'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  category:
      json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
  prices:
      (json['prices'] as List<dynamic>?)
          ?.map((e) => PricesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  brand:
      json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'label': instance.label,
      'images': instance.images,
      'category': instance.category,
      'prices': instance.prices,
      'brand': instance.brand,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) =>
    Category(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

Brand _$BrandFromJson(Map<String, dynamic> json) =>
    Brand(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

PricesModel _$PricesModelFromJson(Map<String, dynamic> json) => PricesModel(
  id: (json['id'] as num?)?.toInt(),
  weight: json['weight'] as String?,
  price: json['price'] as String?,
  quantity: json['quantity'] as String?,
);

Map<String, dynamic> _$PricesModelToJson(PricesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'price': instance.price,
      'quantity': instance.quantity,
    };
