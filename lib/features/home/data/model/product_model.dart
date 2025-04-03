// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:project/features/home/domain/entities/product_entity.dart';

class ProductRecommendModel extends ProductRecommendEntity {
  ProductRecommendModel({required super.items, required super.pagination});

  factory ProductRecommendModel.fromJson(Map<String, dynamic> json) {
    return ProductRecommendModel(
        items: (json['items'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList(),
        pagination: PaginationModel.fromJson(json['pagination']));
  }
}

class PaginationModel extends PaginationEntity {
  PaginationModel(
      {required super.totalItems,
      required super.itemsPerPage,
      required super.currentPage,
      required super.totalPages});

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
        totalItems: json['totalItems'],
        itemsPerPage: int.tryParse(json['totalItems'] ?? "0") ?? 0,
        currentPage: int.tryParse(json['currentPage'] ?? "0") ?? 0,
        totalPages: json['totalPages']);
  }
}

class ProductModel extends ProductEntity {
  ProductModel({
    required int id,
    required String brand,
    required String name,
    required String rating,
    required PriceEntity price,
    required String imageUrl,
  }) : super(
          id: id,
          brand: brand,
          name: name,
          rating: rating,
          price: price,
          imageUrl: imageUrl,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      brand: json['brand'],
      name: json['name'],
      rating: json['rating'].toString(),
      price: PriceEntity.fromJson(json['price']),
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'name': name,
      'rating': rating,
      'price': price.toJson(),
      'image_url': imageUrl,
    };
  }
}

class FavoriteProductModel extends FavoriteProductEntity {
  FavoriteProductModel(
      {required super.brand,
      required super.id,
      required super.image_url,
      required super.max_price,
      required super.min_price,
      required super.name,
      required super.view});

  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProductModel(
        brand: json['brand'],
        id: json['id'],
        image_url: json['image_url'] ?? "",
        max_price: json['max_price'],
        min_price: json['min_price'],
        name: json['name'],
        view: json['view']);
  }
  FavoriteProductEntity toEntity() {
    return FavoriteProductEntity(
      id: id,
      brand: brand,
      name: name,
      min_price: min_price,
      max_price: max_price,
      image_url: image_url,
      view: view,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'name': name,
      'image_url': image_url,
      'max_price': max_price,
      'min_price': min_price,
      'view': view,
    };
  }
}
