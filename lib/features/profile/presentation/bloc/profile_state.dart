part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class AllergicLoaded extends ProfileState {
  final List<AllergyEntity> allergy;

  AllergicLoaded({required this.allergy});

  @override
  // TODO: implement props
  List<Object> get props => [allergy];
}

class UpdateSkinTypeLoading extends ProfileState {}

class UpdateSkintTypeSuccess extends ProfileState {}

class UpdateSkinTypeFailure extends ProfileState {
  final String message;
  UpdateSkinTypeFailure(this.message);
}

class UpdateSkinProblemLoading extends ProfileState {}

class UpdateSkinProblemSuccess extends ProfileState {}

class UpdateSkinProblemFailure extends ProfileState {
  final String message;
  UpdateSkinProblemFailure(this.message);
}

class UpdateAllergicLoading extends ProfileState {}

class UpdateAllergicSuccess extends ProfileState {}

class UpdateAllergicFailure extends ProfileState {
  final String message;
  UpdateAllergicFailure(this.message);
}

class AllergicEmpty extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;

  ProfileLoaded({required this.user});

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
