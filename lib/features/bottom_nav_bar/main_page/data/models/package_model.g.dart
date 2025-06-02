// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageModel _$PackageModelFromJson(Map<String, dynamic> json) => PackageModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  tags: json['tags'] as String?,
  products:
      (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
  cycles:
      (json['cycles'] as List<dynamic>?)
          ?.map((e) => Cycles.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$PackageModelToJson(PackageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'tags': instance.tags,
      'products': instance.products,
      'images': instance.images,
      'cycles': instance.cycles,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  image: json['image'] as String?,
  alternatives:
      (json['alternatives'] as List<dynamic>?)
          ?.map((e) => Alternatives.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image': instance.image,
  'alternatives': instance.alternatives,
};

Alternatives _$AlternativesFromJson(Map<String, dynamic> json) => Alternatives(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  image: json['image'] as String?,
  addOn: json['add_on'] as String?,
  isSelected: json['isSelected'] as bool? ?? false,
);

Map<String, dynamic> _$AlternativesToJson(Alternatives instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'add_on': instance.addOn,
      'isSelected': instance.isSelected,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) =>
    Images(id: (json['id'] as num?)?.toInt(), url: json['url'] as String?);

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
};

Cycles _$CyclesFromJson(Map<String, dynamic> json) => Cycles(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  status: (json['status'] as num?)?.toInt(),
  days: (json['days'] as List<dynamic>?)?.map((e) => e as String).toList(),
  daysCount: (json['days_count'] as num?)?.toInt(),
  price: json['price'] as String?,
);

Map<String, dynamic> _$CyclesToJson(Cycles instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': instance.status,
  'days': instance.days,
  'days_count': instance.daysCount,
  'price': instance.price,
};
