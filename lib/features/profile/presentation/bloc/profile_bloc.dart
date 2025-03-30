import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/features/profile/domain/entities/user_entity.dart';
import 'package:project/features/profile/domain/usecases/get_query_text.dart';
import 'package:project/features/profile/domain/usecases/get_user_info.dart';
import 'package:project/features/profile/domain/usecases/skin_problem.dart';
import 'package:project/features/profile/domain/usecases/update_allergic.dart';
import 'package:project/features/profile/domain/usecases/update_skin_type.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserInfo getUserInfo;
  final GetQueryText getQueryText;
  final UpdateAllergic updateAllergic;
  final SkinProblem skinProblem;
  final UpdateSkinType updateSkinType;
  ProfileBloc({
    required this.getUserInfo,
    required this.getQueryText,
    required this.updateAllergic,
    required this.skinProblem,
    required this.updateSkinType,
  }) : super(ProfileLoading()) {
    on<ProfileLoadEvent>(_onLoadProfile);
    on<QueryIngredientAllergic>(_onQueryIngredientAllergic);
    on<DeleteQuery>(_onDeleteQuery);
    on<UpdateAlleregicEvent>(_onUpdateAlleregic);
    on<UpdateSkinProblemSectionEvent>(_onUpdateSkinProblemSectionEvent);
    on<UpdateSkinTypeEvent>(_onUpdateSkinTypeEvent);
  }

  Future<void> _onUpdateSkinTypeEvent(
      UpdateSkinTypeEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateSkinTypeLoading());
    try {
      await updateSkinType(event.skintTypeId);
      await Duration(seconds: 4);
      emit(UpdateSkintTypeSuccess());
    } catch (e) {
      emit(UpdateSkinTypeFailure(e.toString()));
    }
  }

  Future<void> _onUpdateSkinProblemSectionEvent(
      UpdateSkinProblemSectionEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateSkinProblemLoading());
    try {
      await skinProblem(onAdd: event.onAdd, onDelete: event.onDelete);

      emit(UpdateSkinProblemSuccess());
    } catch (e) {
      emit(UpdateSkinProblemFailure(e.toString()));
    }
  }

  Future<void> _onUpdateAlleregic(
      UpdateAlleregicEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateAllergicLoading());
    if (event.onAdd.isEmpty && event.onDelete.isEmpty) {
      print("Error: onAdd or onDelete is null");
      emit(UpdateAllergicSuccess());
      return;
    }
    List<int> onAddId = event.onAdd.map((e) => e.id).toList();
    List<int> onDeleteId = event.onDelete.map((e) => e.id).toList();

    try {
      await updateAllergic(onAdd: onAddId, onDelete: onDeleteId);
      emit(UpdateAllergicSuccess());
    } catch (e) {
      emit(UpdateAllergicFailure(e.toString()));
    }
  }

  Future<void> _onDeleteQuery(
      DeleteQuery event, Emitter<ProfileState> emit) async {
    emit(AllergicEmpty());
  }

  Future<void> _onQueryIngredientAllergic(
      QueryIngredientAllergic event, Emitter<ProfileState> emit) async {
    try {
      final allergic = await getQueryText(event.query);

      emit(AllergicLoaded(allergy: allergic));
    } catch (e) {}
  }

  Future<void> _onLoadProfile(
      ProfileLoadEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    try {
      final userDetail = await getUserInfo();

      emit(ProfileLoaded(user: userDetail));
    } catch (e) {
      emit(ProfileError(message: "${e.toString()}"));
    }
  }
}
