part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductDetailLoading extends ProductState {}

class ProductDetailLoaded extends ProductState {
  final ProductEntity product;
  final bool isFav;
  final bool isRoutine;
  final int? routineCount;
  final List<ProductRelateEntity> productRelate;

  ProductDetailLoaded({
    required this.product,
    required this.isFav,
    this.isRoutine = false, // ค่าเริ่มต้น
    this.routineCount = 0, // ค่าเริ่มต้น
    required this.productRelate,
  });

  ProductDetailLoaded copyWith({
    ProductEntity? product,
    bool? isFav,
    bool? isRoutine,
    int? routineCount,
    List<ProductRelateEntity>? productRelate,
  }) {
    return ProductDetailLoaded(
        product: product ?? this.product,
        isFav: isFav ?? this.isFav,
        isRoutine: isRoutine ?? this.isRoutine,
        routineCount: routineCount ?? this.routineCount,
        productRelate: productRelate ?? this.productRelate);
  }

  @override
  List<Object?> get props => [product, isFav, isRoutine, routineCount];
}

class ProductFav extends ProductState {
  final bool isFav;
  ProductFav({required this.isFav});

  @override
  List<Object?> get props => [isFav];
}

class ProductDetailError extends ProductState {
  final String message;
  ProductDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
