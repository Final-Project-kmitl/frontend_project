part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnSearchQueryChanged extends SearchEvent {
  final String params;

  OnSearchQueryChanged({required this.params});
}

class SearchLoadBybenefitEvent extends SearchEvent {
  final String query;
  final int page;
  final int? minPrice;
  final int? maxPrice;
  final List<int>? skinTypeIds;
  final List<int>? benefitIds;
  final List<int>? productTypeIds;
  final List<int>? skinProblemIds;
  final List<String>? brands;
  SearchLoadBybenefitEvent({
    required this.query,
    required this.page,
    this.benefitIds,
    this.brands,
    this.maxPrice,
    this.minPrice,
    this.productTypeIds,
    this.skinProblemIds,
    this.skinTypeIds,
  });
}

class OnLoadMoreEvent extends SearchEvent {
  final String query;
  final int page;
  final int? minPrice;
  final int? maxPrice;
  final List<int>? skinTypeIds;
  final List<int>? benefitIds;
  final List<int>? productTypeIds;
  final List<int>? skinProblemIds;
  final List<String>? brands;
  OnLoadMoreEvent({
    required this.query,
    required this.page,
    this.benefitIds,
    this.brands,
    this.maxPrice,
    this.minPrice,
    this.productTypeIds,
    this.skinProblemIds,
    this.skinTypeIds,
  });
}

class OnProductSelected extends SearchEvent {
  final ProductEntity product;

  OnProductSelected(this.product);
}

class OnEmptyEvent extends SearchEvent {}

class OnSubmitEvent extends SearchEvent {
  final String query;
  final int? minPrice;
  final int? maxPrice;
  final List<int>? skinTypeIds;
  final List<int>? benefitIds;
  final List<int>? productTypeIds;
  final List<int>? skinProblemIds;
  final List<String>? brands;
  OnSubmitEvent({
    required this.query,
    this.benefitIds,
    this.brands,
    this.maxPrice,
    this.minPrice,
    this.productTypeIds,
    this.skinProblemIds,
    this.skinTypeIds,
  });
}
