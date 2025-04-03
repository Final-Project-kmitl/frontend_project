import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/core/constants/exception.dart';
import 'package:project/features/routine/domain/entities/no_match_entity.dart';
import 'package:project/features/routine/domain/entities/product_entity.dart';
import 'package:project/features/routine/domain/usecases/add_routine.dart';
import 'package:project/features/routine/domain/usecases/delete_product.dart';
import 'package:project/features/routine/domain/usecases/get_more_query.dart';
import 'package:project/features/routine/domain/usecases/get_no_match_routine.dart';
import 'package:project/features/routine/domain/usecases/get_product_routine.dart';
import 'package:project/features/routine/domain/usecases/get_query.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  final GetNoMatchRoutine getNoMatchRoutine;
  final GetProductRoutine getProductRoutine;
  final DeleteProduct deleteProduct;
  final GetQueryRoutine getQuery;
  final GetMoreQuery getMoreQuery;
  final AddRoutine addRoutine;
  Timer? _debouce;
  String _lastQuery = "";

  RoutineBloc(
      {required this.getNoMatchRoutine,
      required this.getProductRoutine,
      required this.deleteProduct,
      required this.getQuery,
      required this.getMoreQuery,
      required this.addRoutine})
      : super(RoutineLoading()) {
    on<RoutineDeleteEvent>(_onRoutineDeleteEvent);
    on<LoadRoutineEvent>(_onLoadRoutineEvent);
    on<LoadRoutineAndNoMatchEvent>(_onLoadRoutineAndNoMatchEvent);
    on<OnRoutineQueryEvent>(_onRoutineQueryEvent);
    on<OnRoutineQueryLoadMoreEvent>(_onRoutineQueryLoadMoreEvent);
    on<AddRoutineEvent>(_onAddRoutine);
  }

  Future<void> _onAddRoutine(
      AddRoutineEvent event, Emitter<RoutineState> emit) async {
    final currentState = state as RoutineQueryLoaded;
    try {
      await addRoutine(event.productId);

      final updatedProducts = currentState.products.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(isRoutine: true);
        }
        return product;
      }).toList();

      // คำนวณ count ใหม่
      final newCount = updatedProducts.where((p) => p.isRoutine == true).length;

      emit(currentState.copyWith(products: updatedProducts, count: newCount));
    } on SocketException {
      AddroutineFailure(message: Exception_String.netwok_error);
    } on TimeoutException {
      AddroutineFailure(message: Exception_String.timeout_error);
    } catch (e) {
      AddroutineFailure(message: e.toString());
    }
  }

  Future<void> _onRoutineQueryLoadMoreEvent(
      OnRoutineQueryLoadMoreEvent event, Emitter<RoutineState> emit) async {
    if (state is RoutineQueryLoaded) {
      final currentState = state as RoutineQueryLoaded;

      emit(currentState.copyWith(isLoadMore: true));

      try {
        final moreData =
            await getMoreQuery.call(query: event.query, page: event.page);

        print("MORE DATA :${moreData}");

        print("More data loaded: ${moreData.length}");

        emit(currentState.copyWith(
          products: [...currentState.products, ...moreData],
          isLoadMore: false,
        ));
      } catch (e) {
        emit(currentState.copyWith(isLoadMore: false));
      }
    }
  }

  Future<void> _onRoutineQueryEvent(
      OnRoutineQueryEvent event, Emitter<RoutineState> emit) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      _debouce?.cancel();
      emit(RoutineQueryEmpty());
      _lastQuery = query;
      return;
    }

    if (_lastQuery == query) return;
    _lastQuery = query;

    _debouce?.cancel();
    emit(RoutineQueryLoading());

    final completer = Completer<void>();

    _debouce = Timer(Duration(milliseconds: 300), () async {
      try {
        final result = await getQuery(query);
        if (_lastQuery == query && !emit.isDone) {
          emit(RoutineQueryLoaded(
              products: result['products'], count: result['count']));
        }
      } on TimeoutException {
        if (_lastQuery == query && !emit.isDone) {
          emit(RoutineQueryFailure(Exception_String.timeout_error));
        }
      } on SocketException {
        if (_lastQuery == query && !emit.isDone) {
          emit(RoutineQueryFailure(Exception_String.netwok_error));
        }
      } catch (e) {
        if (_lastQuery == query && !emit.isDone) {
          emit(RoutineQueryFailure("Something went wrong. Please try again."));
        }
      } finally {
        completer.complete();
      }
    });

    await completer.future;
  }

  Future<void> _onLoadRoutineAndNoMatchEvent(
      LoadRoutineAndNoMatchEvent event, Emitter<RoutineState> emit) async {
    emit(RoutineLoading());
    try {
      final results = await Future.wait([
        getProductRoutine(),
        getNoMatchRoutine(),
      ]);

      final productData = results[0] as List<ProductEntity>;
      final noMatchData = results[1] as List<NoMatchEntity>;

      emit(RoutineDataLoaded(
        productsRoutine: productData,
        nomatRoutine: noMatchData,
      ));
    } catch (e) {
      emit(RoutineLoadError(message: e.toString()));
    }
  }

  Future<void> _onRoutineDeleteEvent(
      RoutineDeleteEvent event, Emitter<RoutineState> emit) async {
    final currentState = state;
    print("📌 Bloc ได้รับ Event: ${event.productId}");

    if (currentState is RoutineDataLoaded) {
      emit(RoutineLoading()); // แสดง loading ระหว่างลบ

      try {
        await deleteProduct.deleteProdcutRoiutine(event.productId);

        // 🔥 เพิ่ม emit ให้แจ้งว่า Delete สำเร็จ
        emit(RoutineDeleteSuccess());
      } catch (e) {
        emit(RoutineLoadError(message: "Failed to delete products"));
      }
    }
  }

  Future<void> _onLoadRoutineEvent(
      LoadRoutineEvent event, Emitter<RoutineState> emit) async {
    emit(RoutineLoading());
    try {
      final productData = await getProductRoutine();

      emit(RoutineDataLoaded(
        productsRoutine: productData,
        nomatRoutine: [],
      ));
    } catch (e) {
      emit(RoutineLoadError(message: e.toString()));
    }
  }

  // Future<void> _onLoadNoMatchEvent(
  //     LoadNoMatchEvent event, Emitter<RoutineState> emit) async {
  //   try {
  //     final noMatchData = await getNoMatchRoutine();
  //     final currentState = state;

  //     if (currentState is RoutineDataLoaded) {
  //       emit(RoutineDataLoaded(
  //         productsRoutine: currentState.productsRoutine, // ✅ เก็บค่าที่มีอยู่
  //         nomatRoutine: noMatchData,
  //       ));
  //     } else {
  //       emit(RoutineDataLoaded(
  //         productsRoutine: [],
  //         nomatRoutine: noMatchData,
  //       ));
  //     }
  //   } catch (e) {
  //     emit(RoutineLoadError(message: e.toString()));
  //   }
  // }
}
