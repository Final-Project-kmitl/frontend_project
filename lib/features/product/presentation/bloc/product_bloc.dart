import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';
import 'package:project/core/constants/exception.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/features/product/domain/entities/product_entity.dart';
import 'package:project/features/product/domain/usecases/add_product_routine.dart';
import 'package:project/features/product/domain/usecases/get_product_detail.dart';
import 'package:project/features/product/domain/usecases/toggle_favorite_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductDetail getProductDetail;
  final ToggleFavoriteProduct toggleFavoriteProduct;
  final HomeBloc homeBloc;
  final AddProductRoutine addProductRoutine;
  ProductBloc({
    required this.getProductDetail,
    required this.toggleFavoriteProduct,
    required this.homeBloc,
    required this.addProductRoutine,
  }) : super(ProductDetailLoading()) {
    on<ProductDetailRequestedEvent>(_onProductLoad);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<AddProductToRoutineEvent>(_onAddProductToRoutineEvent);
  }

  Future<void> _onAddProductToRoutineEvent(
      AddProductToRoutineEvent event, Emitter<ProductState> emit) async {
    final currentState = state as ProductDetailLoaded;

    final newRoutineCount = currentState.routineCount! + 1;
    try {
      await addProductRoutine(event.productId);

      emit(currentState.copyWith(
          isRoutine: true, routineCount: newRoutineCount));
    } on SocketException {
      ProductDetailError(message: Exception_String.netwok_error);
    } on TimeoutException {
      ProductDetailError(message: Exception_String.timeout_error);
    } catch (e) {
      ProductDetailError(message: e.toString());
    }
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event, Emitter<ProductState> emit) async {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      final bool newFavStatus = currentState.isFav;

      print("NEW FAV $newFavStatus");

      try {
        await toggleFavoriteProduct(event.productId, newFavStatus);

        // final updatedProduct =
        // currentState.product.copyWith(isFav: newFavStatus);

        emit(ProductDetailLoaded(
            product: currentState.product,
            isFav: !newFavStatus,
            isRoutine: currentState.isRoutine,
            routineCount: currentState.routineCount,
            productRelate: currentState.productRelate));

        print("emit");

        homeBloc.add(UpdateUIEvent(
            isFavorite: !newFavStatus, productId: event.productId));

        print(
            "⭐ Favorite Updated: ${currentState.product.isFav} -> $newFavStatus");
      } catch (e) {
        print("❌ Failed to update favoriteasdfasfd: ${e.toString()}");
      }
    }
  }

  Future<void> _onProductLoad(
      ProductDetailRequestedEvent event, Emitter<ProductState> emit) async {
    emit(ProductDetailLoading());
    print("📌 เริ่มโหลด productId: ${event.productId}");

    try {
      final res = await getProductDetail(event.productId);
      print("✅ ข้อมูลที่ได้จาก API: $res");

      if (res == null) {
        throw Exception("API ส่งค่ากลับมาเป็น null");
      }

      // ตรวจสอบให้แน่ใจว่าค่าเหล่านี้มีข้อมูลเสมอ แม้จะเป็นค่าเริ่มต้น
      final bool isRoutine = res.isRoutine;
      final int routineCount = res.routineCount ?? 0;
      final bool isFav = res.isFav;
      final List<ProductRelateEntity> relate = res.productRelate!;

      emit(ProductDetailLoaded(
          product: res,
          isFav: isFav,
          isRoutine: isRoutine,
          routineCount: routineCount,
          productRelate: relate));

      print("✅ โหลดสำเร็จ: ${event.productId}");
    } catch (e, stackTrace) {
      print("❌ โหลดล้มเหลว: $e");
      print(stackTrace);
      emit(ProductDetailError(message: "Fail to load: ${e.toString()}"));
    }
  }
}
