import 'package:project/features/favorite/domain/entities/fav_product.dart';

class FavProductModel extends FavProductEntities {
  const FavProductModel(
      {required super.id,
      required super.product,
      required super.brand,
      required super.minPrice,
      required super.maxPrice,
      required super.img,
      required super.rating});

  factory FavProductModel.fromJson(Map<String, dynamic> json) {
    return FavProductModel(
        id: json["id"],
        product: json["product"],
        brand: json["brand"],
        minPrice: json["minPrice"],
        maxPrice: json["maxPrice"],
        img: json["img"],
        rating: json["rating"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'brand': brand,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'img': img,
      'rating': rating,
    };
  }
}
