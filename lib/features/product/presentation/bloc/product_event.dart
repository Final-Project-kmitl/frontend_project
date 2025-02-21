part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailRequestedEvent extends ProductEvent {
  final int productId;

  ProductDetailRequestedEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
