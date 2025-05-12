// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageModel _$PackageModelFromJson(Map<String, dynamic> json) => PackageModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  price: json['price'] as String?,
  total: (json['total'] as num?)?.toInt(),
  status: json['status'] as String?,
  tags: json['tags'] as String?,
  products:
      (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$PackageModelToJson(PackageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'total': instance.total,
      'status': instance.status,
      'tags': instance.tags,
      'products': instance.products,
      'images': instance.images,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  alternatives:
      (json['alternatives'] as List<dynamic>?)
          ?.map((e) => Alternatives.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'alternatives': instance.alternatives,
};

Alternatives _$AlternativesFromJson(Map<String, dynamic> json) => Alternatives(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  addOn: json['addOn'] as String?,
);

Map<String, dynamic> _$AlternativesToJson(Alternatives instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'addOn': instance.addOn,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) =>
    Images(id: (json['id'] as num?)?.toInt(), url: json['url'] as String?);

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
};
