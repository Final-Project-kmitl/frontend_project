import 'package:project/features/routine/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.brand,
    required super.product,
    required super.img,
    required super.isRoutine,
  });

  // Json -> Obj
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      brand: json['brand'],
      product: json['name'],
      img: json['image_url'] ?? "",
      isRoutine: false,
    );
  }

  // obj -> json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'product': product,
      'img': img,
    };
  }

  ProductEntity copyWith({
    int? id,
    String? brand,
    String? product,
    String? img,
    bool? isRoutine,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      product: product ?? this.product,
      img: img ?? this.img,
      isRoutine: isRoutine ?? this.isRoutine,
    );
  }
}
