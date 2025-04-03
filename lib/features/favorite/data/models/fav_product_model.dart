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
        product: json["name"],
        brand: json["brand"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        img: json["image_url"],
        rating: json["view"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'brand': brand,
      'min_price': minPrice,
      'max_price': maxPrice,
      'image_url': img,
      'view': rating,
    };
  }
}
