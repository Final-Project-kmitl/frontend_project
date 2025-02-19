part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductEntity> recommended;
  final List<ProductEntity> popular;
  final List<ProductEntity> recent;
  final List<FavoriteProductEntity> favorite;

  HomeLoaded({
    required this.recommended,
    required this.popular,
    required this.recent,
    required this.favorite,
  });

  HomeLoaded copyWith({
    List<ProductEntity>? recommended,
    List<ProductEntity>? popular,
    List<ProductEntity>? recent,
    List<FavoriteProductEntity>? favorite,
  }) {
    return HomeLoaded(
      recommended: recommended ?? this.recommended,
      popular: popular ?? this.popular,
      recent: recent ?? this.recent,
      favorite: favorite ?? this.favorite,
    );
  }

  @override
  List<Object> get props => [
        recommended,
        popular,
        recent,
        favorite,
      ];
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeFavoriteUpdated extends HomeState {
  final List<FavoriteProductEntity> favorite;

  HomeFavoriteUpdated({required this.favorite});

  @override
  List<Object> get props => [favorite];
}
