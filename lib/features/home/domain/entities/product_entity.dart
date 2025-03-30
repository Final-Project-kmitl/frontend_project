// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductEntity {
  final int id;
  final String brand;
  final String name;
  final String rating;
  final PriceEntity price;
  final String? imageUrl;
  ProductEntity(
      {required this.brand,
      required this.id,
      this.imageUrl,
      required this.name,
      required this.price,
      required this.rating});
}

class ProductRecommendEntity {
  final List<ProductEntity> items;
  final PaginationEntity? pagination;
  ProductRecommendEntity({
    required this.items,
    this.pagination,
  });
}

class PaginationEntity {
  final int totalItems;
  final int itemsPerPage;
  final int currentPage;
  final int totalPages;
  PaginationEntity({
    required this.totalItems,
    required this.itemsPerPage,
    required this.currentPage,
    required this.totalPages,
  });

  PaginationEntity copyWith({
    int? totalItems,
    int? itemsPerPage,
    int? currentPage,
    int? totalPages,
  }) {
    return PaginationEntity(
      totalItems: totalItems ?? this.totalItems,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
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
  final String? image_url;
  final String view;
  FavoriteProductEntity(
      {required this.brand,
      required this.id,
      this.image_url,
      required this.max_price,
      required this.min_price,
      required this.name,
      required this.view});
}
