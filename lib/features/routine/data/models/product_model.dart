import 'package:project/features/routine/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required super.id,
      required super.brand,
      required super.product,
      required super.img});

  // Json -> Obj
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: int.parse(json["id"]),
        brand: json['brand'],
        product: json['product'],
        img: json['img']);
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
}
