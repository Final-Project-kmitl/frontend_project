part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchSearchData extends SearchEvent {}

class SubmitSearchQuery extends SearchEvent {
  final String query;
  SubmitSearchQuery({required this.query});
}
