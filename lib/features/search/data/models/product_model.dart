import 'package:project/features/search/domain/entities/search_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required super.id,
      required super.brand,
      required super.name,
      required super.rating,
      required super.minPrice,
      required super.maxPrice,
      required super.imageUrl,
      required super.view});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      brand: json['brand'],
      name: json['name'],
      rating:
          double.tryParse(json['rating'].toString()) ?? 0.0, // ✅ ป้องกัน error
      minPrice:
          int.tryParse(json['price']['min'].toString()) ?? 0, // ✅ ป้องกัน error
      maxPrice: int.tryParse(json['price']['max'].toString()) ?? 0,
      imageUrl: json['image_url'] ?? "",
      view: int.parse(json['view']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'name': name,
      'rating': rating,
      'price': {
        'min': minPrice.toString(),
        'max': maxPrice.toString(),
      },
      'image_url': imageUrl,
      'view': view.toString(),
    };
  }
}
