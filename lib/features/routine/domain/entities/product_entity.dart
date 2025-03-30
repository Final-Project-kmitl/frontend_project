class ProductEntity {
  final int id;
  final String brand;
  final String product;
  final String img;
  final bool? isRoutine;
  ProductEntity({
    required this.id,
    required this.brand,
    required this.product,
    required this.img,
    this.isRoutine,
  });

  ProductEntity copyWith({
    int? id,
    String? brand,
    String? product,
    String? img,
    bool? isRoutine,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      product: product ?? this.product,
      img: img ?? this.img,
      isRoutine: isRoutine ?? this.isRoutine,
    );
  }
}
