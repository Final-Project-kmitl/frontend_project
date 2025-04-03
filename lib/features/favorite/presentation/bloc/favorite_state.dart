part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  final List<FavProductEntities> favorites;
  final Set<int>? unfavList;
  FavoriteLoaded({required this.favorites, this.unfavList});

  FavoriteLoaded copyWith({
    List<FavProductEntities>? favorites,
    Set<int>? unfavList,
  }) {
    return FavoriteLoaded(
      favorites: favorites ?? this.favorites,
      unfavList: unfavList ?? this.unfavList,
    );
  }
}

final class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError({required this.message});
}
