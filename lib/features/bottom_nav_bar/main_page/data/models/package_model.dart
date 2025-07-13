import 'package:json_annotation/json_annotation.dart';
part 'package_model.g.dart';

@JsonSerializable()
class PackageModel {
  int? id;
  String? name;
  String? description;
  String? tags;
  List<Products>? products;
  List<Images>? images;
  List<Cycles>? cycles;

  PackageModel({
    this.id,
    this.name,
    this.description,
    this.tags,
    this.products,
    this.images,
    this.cycles,
  });

  copyWith({
    int? id,
    String? name,
    String? description,
    String? price,
    String? total,
    String? tags,
    List<Products>? products,
    List<Images>? images,
    List<Cycles>? cycles,
  }) {
    return PackageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      products: products ?? this.products,
      images: images ?? this.images,
      cycles: cycles ?? this.cycles,
    );
  }

  factory PackageModel.fromJson(Map<String, dynamic> json) =>
      _$PackageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackageModelToJson(this);
}

@JsonSerializable()
class Products {
  int? id;
  String? name;
  String? image;
  List<Alternatives>? alternatives;

  Products({this.id, this.name, this.image, this.alternatives});

  copyWith({
    int? id,
    String? name,
    String? image,
    List<Alternatives>? alternatives,
  }) {
    return Products(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      alternatives: alternatives ?? this.alternatives,
    );
  }

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}

@JsonSerializable()
class Alternatives {
  int? id;
  String? name;
  String? image;
  @JsonKey(name: 'add_on')
  String? addOn;
  bool isSelected;

  Alternatives({
    this.id,
    this.name,
    this.image,
    this.addOn,
    this.isSelected = false,
  });

  copyWith({
    int? id,
    String? name,
    String? image,
    String? addOn,
    bool? isSelected,
  }) {
    return Alternatives(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      addOn: addOn ?? this.addOn,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory Alternatives.fromJson(Map<String, dynamic> json) =>
      _$AlternativesFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativesToJson(this);
}

@JsonSerializable()
class Images {
  int? id;
  String? url;

  Images({this.id, this.url});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}

@JsonSerializable()
class Cycles {
  int? id;
  String? name;
  int? status;
  List<String>? days;
  @JsonKey(name: 'days_count')
  int? daysCount;
  String? price;

  Cycles({
    this.id,
    this.name,
    this.status,
    this.days,
    this.daysCount,
    this.price,
  });

  factory Cycles.fromJson(Map<String, dynamic> json) => _$CyclesFromJson(json);

  Map<String, dynamic> toJson() => _$CyclesToJson(this);
}
