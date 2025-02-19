class ProductEntity {
  final int id;
  final String brand;
  final String name;
  final String rating;
  final PriceEntity price;
  final String imageUrl;
  ProductEntity(
      {required this.brand,
      required this.id,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.rating});
}

class PriceEntity {
  final String max;
  final String min;
  PriceEntity({
    required this.max,
    required this.min,
  });

  factory PriceEntity.fromJson(Map<String, dynamic> json) {
    return PriceEntity(
      max: json["max"].toString(),
      min: json["min"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'max': max,
      'min': min,
    };
  }
}

class FavoriteProductEntity {
  final int id;
  final String brand;
  final String name;
  final String min_price;
  final String max_price;
  final String image_url;
  final String view;
  FavoriteProductEntity(
      {required this.brand,
      required this.id,
      required this.image_url,
      required this.max_price,
      required this.min_price,
      required this.name,
      required this.view});
}
