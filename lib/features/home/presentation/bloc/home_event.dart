part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeDataRequestedEvent extends HomeEvent {}

class ToggleFavoriteEvent extends HomeEvent {
  final FavoriteProductEntity productFav;
  final bool isFavorite;
  ToggleFavoriteEvent({required this.productFav, required this.isFavorite});

  @override
  List<Object> get props => [productFav, isFavorite];
}
