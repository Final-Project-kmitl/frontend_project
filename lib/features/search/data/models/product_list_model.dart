import 'product_model.dart';

class ProductListModel {
  final List<ProductModel> products;
  final int total;
  final int totalPages;
  final int currentPage;
  final int limit;
  final bool hasNextPage;
  final bool hasPreviousPage;

  ProductListModel({
    required this.products,
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.limit,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      products: (json['data'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList(),
      total: json['pagination']['total'],
      totalPages: json['pagination']['totalPages'],
      currentPage: int.parse(json['pagination']['currentPage']),
      limit: int.parse(json['pagination']['limit']),
      hasNextPage: json['pagination']['hasNextPage'],
      hasPreviousPage: json['pagination']['hasPreviousPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': products.map((product) => product.toJson()).toList(),
      'pagination': {
        'total': total,
        'totalPages': totalPages,
        'currentPage': currentPage.toString(),
        'limit': limit.toString(),
        'hasNextPage': hasNextPage,
        'hasPreviousPage': hasPreviousPage,
      },
    };
  }
}
