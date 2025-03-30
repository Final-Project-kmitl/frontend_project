part of 'routine_bloc.dart';

sealed class RoutineEvent extends Equatable {
  const RoutineEvent();

  @override
  List<Object> get props => [];
}

class LoadRoutineEvent extends RoutineEvent {}

class LoadNoMatchEvent extends RoutineEvent {}

class LoadRoutineAndNoMatchEvent extends RoutineEvent {}

class OnRoutineQueryEvent extends RoutineEvent {
  final String query;
  OnRoutineQueryEvent(this.query);
}

class AddRoutineEvent extends RoutineEvent {
  final int productId;
  AddRoutineEvent({required this.productId});
}

class OnRoutineQueryLoadMoreEvent extends RoutineEvent {
  final String query;
  final int page;
  OnRoutineQueryLoadMoreEvent({required this.query, required this.page});
}

class RoutineDeleteEvent extends RoutineEvent {
  final Set<int> productId;

  RoutineDeleteEvent(Set<int> ids) : productId = Set.from(ids) {
    print("📌 RoutineDeleteEvent สร้างใหม่: $productId");
  }
}
