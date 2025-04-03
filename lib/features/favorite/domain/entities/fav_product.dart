class FavProductEntities {
  final int id;
  final String product;
  final String brand;
  final String minPrice;
  final String maxPrice;
  final String? img;
  final String rating;

  const FavProductEntities({
    required this.id,
    required this.product,
    required this.brand,
    required this.minPrice,
    required this.maxPrice,
     this.img,
    required this.rating,
  });
}
