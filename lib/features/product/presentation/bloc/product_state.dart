part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductDetailLoading extends ProductState {}

final class ProductDetailLoaded extends ProductState {
  final ProductEntity product;

  ProductDetailLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

final class ProductDetailError extends ProductState {
  final String message;
  ProductDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
