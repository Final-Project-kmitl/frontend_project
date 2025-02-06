import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/features/routine/domain/entities/no_match_entity.dart';
import 'package:project/features/routine/domain/entities/product_entity.dart';
import 'package:project/features/routine/domain/usecases/get_no_match_routine.dart';
import 'package:project/features/routine/domain/usecases/get_product_routine.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  final GetNoMatchRoutine getNoMatchRoutine;
  final GetProductRoutine getProductRoutine;

  RoutineBloc({
    required this.getNoMatchRoutine,
    required this.getProductRoutine,
  }) : super(RoutineLoading()) {
    on<LoadRoutineEvent>(_onLoadRoutineEvent);
    on<LoadNoMatchEvent>(_onLoadNoMatchEvent);
  }

  Future<void> _onLoadRoutineEvent(
      LoadRoutineEvent event, Emitter<RoutineState> emit) async {
    try {
      final productData = await getProductRoutine();
      final currentState = state;

      if (currentState is RoutineDataLoaded) {
        emit(RoutineDataLoaded(
          productsRoutine: productData,
          nomatRoutine: currentState.nomatRoutine,
        ));
      } else {
        emit(RoutineDataLoaded(
          productsRoutine: productData,
          nomatRoutine: [],
        ));
      }
    } catch (e) {
      emit(RoutineLoadError(message: e.toString()));
    }
  }

  Future<void> _onLoadNoMatchEvent(
      LoadNoMatchEvent event, Emitter<RoutineState> emit) async {
    try {
      final noMatchData = await getNoMatchRoutine();
      final currentState = state;

      if (currentState is RoutineDataLoaded) {
        emit(RoutineDataLoaded(
          productsRoutine: currentState.productsRoutine, // ✅ เก็บค่าที่มีอยู่
          nomatRoutine: noMatchData,
        ));
      } else {
        emit(RoutineDataLoaded(
          productsRoutine: [],
          nomatRoutine: noMatchData,
        ));
      }
    } catch (e) {
      emit(RoutineLoadError(message: e.toString()));
    }
  }
}
