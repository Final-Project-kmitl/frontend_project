part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoadEvent extends ProfileEvent {}

class QueryIngredientAllergic extends ProfileEvent {
  final String query;
  QueryIngredientAllergic({required this.query});
}

class DeleteQuery extends ProfileEvent {}

class UpdateSkinTypeEvent extends ProfileEvent {
  final int skintTypeId;
  UpdateSkinTypeEvent(this.skintTypeId);
}

class UpdateSkinProblemSectionEvent extends ProfileEvent {
  final List<int> onAdd;
  final List<int> onDelete;
  UpdateSkinProblemSectionEvent({required this.onAdd, required this.onDelete});
}

class UpdateAlleregicEvent extends ProfileEvent {
  final List<AllergyEntity> onAdd;
  final List<AllergyEntity> onDelete;
  UpdateAlleregicEvent({required this.onAdd, required this.onDelete});
}
