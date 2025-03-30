class ProductEntity {
  final int id;
  final String brand;
  final String name;
  final double rating;
  final int minPrice;
  final int maxPrice;
  final String imageUrl;
  final int view;

  const ProductEntity({
    required this.id,
    required this.brand,
    required this.name,
    required this.rating,
    required this.minPrice,
    required this.maxPrice,
    required this.imageUrl,
    required this.view,
  });
}
