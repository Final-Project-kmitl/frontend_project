part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchOnEmpty extends SearchState {}

class SearchLoaded extends SearchState {
  final List<AutoCompleteEntity> products;

  SearchLoaded(this.products);

  SearchLoaded copyWith({
    List<AutoCompleteEntity>? products,
  }) {
    return SearchLoaded(products ?? this.products);
  }
}



class SubmitLoaded extends SearchState {
  final SubmitReturnEntity submitReturn;
  SubmitLoaded({required this.submitReturn});

  SubmitLoaded copyWith({
    final SubmitReturnEntity? submitReturnEntity,
  }) {
    return SubmitLoaded(submitReturn: submitReturnEntity ?? this.submitReturn);
  }
}

class SearchSelected extends SearchState {
  final ProductEntity product;

  SearchSelected(this.product);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
