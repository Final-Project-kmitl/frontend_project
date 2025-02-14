part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class LoadFavoritesEvent extends FavoriteEvent {}

class ToggleFavoriteEvent extends FavoriteEvent {
  final int productId;
  ToggleFavoriteEvent({required this.productId});
}

class SubmitUnfavoriteEvent extends FavoriteEvent {}
