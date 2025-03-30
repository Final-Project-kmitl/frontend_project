part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductToRoutineEvent extends ProductEvent {
  final int productId;

  AddProductToRoutineEvent({required this.productId});
}


class ProductDetailRequestedEvent extends ProductEvent {
  final int productId;

  ProductDetailRequestedEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class ToggleFavoriteEvent extends ProductEvent {
  final int productId;
  final bool isFavorite;
  ToggleFavoriteEvent({required this.productId, required this.isFavorite});

  @override
  List<Object> get props => [productId, isFavorite];
}
