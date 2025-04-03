part of 'routine_bloc.dart';

sealed class RoutineState extends Equatable {
  const RoutineState();

  @override
  List<Object> get props => [];
}

class RoutineQueryLoading extends RoutineState {}

class RoutineQueryLoaded extends RoutineState {
  final List<ProductEntity> products;
  final bool isLoadMore;
  final int count;
  RoutineQueryLoaded(
      {required this.products, this.isLoadMore = false, this.count = 0});

  RoutineQueryLoaded copyWith({
    List<ProductEntity>? products,
    bool? isLoadMore,
    int? count,
  }) {
    return RoutineQueryLoaded(
      products: products ?? this.products,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      count: count ?? this.count,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [products, isLoadMore, count];
}

class AddroutineFailure extends RoutineState {
  final String message;
  AddroutineFailure({required this.message});
}

class RoutineQueryEmpty extends RoutineState {}

class RoutineQueryFailure extends RoutineState {
  final String message;
  RoutineQueryFailure(this.message);
}

final class RoutineInitial extends RoutineState {}

final class RoutineLoading extends RoutineState {}

class RoutineDeleteSuccess extends RoutineState {}

class RoutineDataLoaded extends RoutineState {
  final List<ProductEntity> productsRoutine;
  final List<NoMatchEntity> nomatRoutine;

  RoutineDataLoaded({
    List<ProductEntity>? productsRoutine,
    List<NoMatchEntity>? nomatRoutine,
  })  : productsRoutine = productsRoutine ?? [],
        nomatRoutine = nomatRoutine ?? [];

  @override
  List<Object> get props => [
        productsRoutine,
        nomatRoutine,
      ];
}

final class RoutineLoadError extends RoutineState {
  final String message;
  RoutineLoadError({required this.message});

  @override
  List<Object> get props => [message];
}
