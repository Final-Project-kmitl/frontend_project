part of 'routine_bloc.dart';

sealed class RoutineEvent extends Equatable {
  const RoutineEvent();

  @override
  List<Object> get props => [];
}

class LoadRoutineEvent extends RoutineEvent {}

class LoadNoMatchEvent extends RoutineEvent {}

class RoutineDeleteEvent extends RoutineEvent {
  final Set<int>? productId;

  RoutineDeleteEvent(this.productId);
}
