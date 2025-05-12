import 'package:json_annotation/json_annotation.dart';
part 'package_model.g.dart';

@JsonSerializable()
class PackageModel {
  int? id;
  String? name;
  String? description;
  String? price;
  int? total;
  String? status;
  String? tags;
  List<Products>? products;
  List<Images>? images;

  PackageModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.total,
      this.status,
      this.tags,
      this.products,
      this.images});

  factory PackageModel.fromJson(Map<String, dynamic> json) =>
      _$PackageModelFromJson(json);
}

@JsonSerializable()
class Products {
 int? id;
  String? name;
  List<Alternatives>? alternatives;

  Products({this.id, this.name, this.alternatives});

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
}

@JsonSerializable()
class Alternatives {
   int? id;
  String? name;
  String? addOn;

  Alternatives({this.id, this.name, this.addOn});

  factory Alternatives.fromJson(Map<String, dynamic> json) =>
      _$AlternativesFromJson(json);
}

@JsonSerializable()
class Images {
  int? id;
  String? url;

  Images({this.id, this.url});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
}

