import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:project/features/favorite/domain/entities/fav_product.dart';
import 'package:project/features/favorite/domain/repository/fav_repository.dart';
import 'package:project/features/favorite/domain/usecase/get_favorite.dart';
import 'package:project/features/favorite/domain/usecase/un_fav_favorite.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavorite getFavorite;
  final UnFavFavorite unFavFavorite;
  final HomeBloc homeBloc;

  FavoriteBloc({
    required this.getFavorite,
    required this.unFavFavorite,
    required this.homeBloc,
  }) : super(FavoriteInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<SubmitUnfavoriteEvent>(_onSubmitUnfavorite);

    // โหลด Favorite ตั้งแต่เริ่ม
    add(LoadFavoritesEvent());
  }

  // โหลดรายการ Favorite
  Future<void> _onLoadFavorites(
      LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    print("🔄 กำลังโหลด Favorite...");
    try {
      final favorites = await getFavorite();
      emit(FavoriteLoaded(favorites: favorites, unfavList: {}));
      print("✅ โหลดสำเร็จ: ${favorites.length} รายการ");
    } catch (e) {
      emit(FavoriteError(message: "Failed to load favorites"));
    }
  }

  // กด Unfav (แค่เปลี่ยนไอคอน ยังไม่ลบจาก UI)
  void _onToggleFavorite(
      ToggleFavoriteEvent event, Emitter<FavoriteState> emit) {
    final currentState = state;
    if (currentState is FavoriteLoaded) {
      final newUnfavList = Set<int>.from(currentState.unfavList ?? {});

      if (newUnfavList.contains(event.productId)) {
        newUnfavList.remove(event.productId);
      } else {
        newUnfavList.add(event.productId);
      }

      emit(currentState.copyWith(unfavList: newUnfavList));
      print("⭐ Unfav List ปัจจุบัน: $newUnfavList");
    }
  }

  // ออกจากหน้า Favorite → ส่ง API ไปยัง backend
  Future<void> _onSubmitUnfavorite(
      SubmitUnfavoriteEvent event, Emitter<FavoriteState> emit) async {
    final currentState = state;

    print("📢 SubmitUnfavoriteEvent ถูกเรียก");
    print("📌 State ปัจจุบัน: $currentState");

    if (currentState is! FavoriteLoaded) {
      print("⚠️ State ยังไม่พร้อม ไม่สามารถ unfavorite ได้");
      return;
    }

    final unfavList = currentState.unfavList ?? {};
    if (unfavList.isEmpty) {
      print("⚠️ ไม่มีรายการที่จะ unfavorite");
      return;
    }

    unfavList.forEach((e) {
      print(e);
      homeBloc.add(UpdateUIEvent(isFavorite: false, productId: e));
    });
    print("✅ กำลังส่ง Unfavorite: $unfavList");
    try {
      await unFavFavorite(unfavList);
      emit(currentState.copyWith(unfavList: {}));
      print("✅ ล้างรายการ unfav สำเร็จ");
    } catch (e) {
      print("❌ ล้มเหลว: $e");
      emit(FavoriteError(message: "Failed to update favorites"));
    }
  }
}
