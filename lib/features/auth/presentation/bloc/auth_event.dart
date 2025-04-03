// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResetAuthState extends AuthEvent {}

class SendingDataToBackend extends AuthEvent {
  final int userId;
  final String skinType;
  final List<int>? allergicListId;
  final List<int> benefitListId;
  SendingDataToBackend({
    required this.userId,
    required this.skinType,
    this.allergicListId,
    required this.benefitListId,
  });
}

class AuthQueryChanged extends AuthEvent {
  final String query;
  AuthQueryChanged({required this.query});

  @override
  // TODO: implement props
  List<Object> get props => [query];
}

class AuthItemSelected extends AuthEvent {
  final IngredientEntity ingredient;
  AuthItemSelected({required this.ingredient});

  @override
  // TODO: implement props
  List<Object> get props => [ingredient];
}
