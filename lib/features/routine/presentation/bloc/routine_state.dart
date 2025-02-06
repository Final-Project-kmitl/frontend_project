part of 'routine_bloc.dart';

sealed class RoutineState extends Equatable {
  const RoutineState();

  @override
  List<Object> get props => [];
}

final class RoutineInitial extends RoutineState {}

final class RoutineLoading extends RoutineState {}

class RoutineDataLoaded extends RoutineState {
  final List<ProductEntity> productsRoutine;
  final List<NoMatchEntity> nomatRoutine;

  RoutineDataLoaded({
    List<ProductEntity>? productsRoutine,
    List<NoMatchEntity>? nomatRoutine,
  })  : productsRoutine = productsRoutine ?? [],
        nomatRoutine = nomatRoutine ?? [];

  @override
  List<Object> get props => [productsRoutine, nomatRoutine];
}

final class RoutineLoadError extends RoutineState {
  final String message;
  RoutineLoadError({required this.message});

  @override
  List<Object> get props => [message];
}
