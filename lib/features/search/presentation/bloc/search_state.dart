part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchTexting extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<String> localSearch;
  final List<String> popularSearch;

  SearchLoaded({required this.localSearch, required this.popularSearch});
}

final class SearchError extends SearchState {}
