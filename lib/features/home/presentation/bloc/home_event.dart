part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeDataRequestedEvent extends HomeEvent {}

class LoadRecommendedEvent extends HomeEvent {}

class LoadPopularEvent extends HomeEvent {}

class LoadRecentEvent extends HomeEvent {}

class LoadFavoriteEvent extends HomeEvent {}

class LoadByBenefitEvent extends HomeEvent {
  final int benefitId;

  LoadByBenefitEvent({required this.benefitId});
}

class RestoreHomeEvent extends HomeEvent {}

class LoadMoreByBenefitEvent extends HomeEvent {
  final int benefitId;
  final int page;
  LoadMoreByBenefitEvent({required this.benefitId, required this.page});
}

class UpdateUIEvent extends HomeEvent {
  final int productId;
  final bool isFavorite;
  UpdateUIEvent({required this.isFavorite, required this.productId});

  @override
  List<Object> get props => [productId, isFavorite];
}

class ToggleFavoriteEvent extends HomeEvent {
  final int productId;
  final bool isFavorite;
  ToggleFavoriteEvent({required this.productId, required this.isFavorite});

  @override
  List<Object> get props => [productId, isFavorite];
}
