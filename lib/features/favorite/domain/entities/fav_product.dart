class FavProductEntities {
  final int id;
  final String product;
  final String brand;
  final int minPrice;
  final int maxPrice;
  final String img;
  final int rating;

  const FavProductEntities({
    required this.id,
    required this.product,
    required this.brand,
    required this.minPrice,
    required this.maxPrice,
    required this.img,
    required this.rating,
  });
}
