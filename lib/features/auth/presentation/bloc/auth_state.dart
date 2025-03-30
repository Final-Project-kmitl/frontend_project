part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

class SearchOnEmpty extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final List<IngredientEntity> ingredients;
  AuthLoaded({required this.ingredients});

  @override
  // TODO: implement props
  List<Object> get props => [ingredients];
}

class AuthSearchSelectedItemsUpdated extends AuthState {
  final List<IngredientEntity> selectedItems;
  AuthSearchSelectedItemsUpdated({required this.selectedItems});

  @override
  // TODO: implement props
  List<Object?> get props => [selectedItems];
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
