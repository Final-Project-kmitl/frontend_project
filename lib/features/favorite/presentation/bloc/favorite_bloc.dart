import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:project/features/favorite/data/models/fav_product_model.dart';
import 'package:project/features/favorite/domain/entities/fav_product.dart';
import 'package:project/features/favorite/domain/repository/fav_repository.dart';
import 'package:project/features/favorite/domain/usecase/get_favorite.dart';
import 'package:project/features/favorite/domain/usecase/un_fav_favorite.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavRepository favRepository;
  FavoriteBloc(this.favRepository) : super(FavoriteInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<SubmitUnfavoriteEvent>(_onSubmitUnfavorite);
  }

  // โหลดรายการ Favorite
  Future<void> _onLoadFavorites(
      LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());

    try {
      final favorites = await favRepository.getFavProduct();
      print("FAV : ${favorites}");

      emit(FavoriteLoaded(favorites: favorites));
    } catch (e) {
      print("FAV123123");
      print(e);
      emit(FavoriteError(message: "Failed to load favorites"));
    }
  }

// กด Unfav (แค่เปลี่ยนไอคอน ยังไม่ลบจาก UI)
  void _onToggleFavorite(
      ToggleFavoriteEvent event, Emitter<FavoriteState> emit) {
    final currentState = state;
    if (currentState is FavoriteLoaded) {
      final newUnfavList =
          Set<int>.from((currentState.unfavList ?? {}).cast<int>());
      if (newUnfavList.contains(event.productId)) {
        newUnfavList.remove(event.productId); // ถ้ากดอีกครั้งให้ fav กลับ
      } else {
        newUnfavList.add(event.productId);
      }
      emit(currentState.copyWith(unfavList: newUnfavList));
    }
  }

// ออกจากหน้า Favorite → ส่ง API ไปยัง backend
  Future<void> _onSubmitUnfavorite(
      SubmitUnfavoriteEvent event, Emitter<FavoriteState> emit) async {
    final currentState = state;
    if (currentState is FavoriteLoaded &&
        (currentState.unfavList?.isNotEmpty ?? false)) {
      try {
        await favRepository
            .unFavProduct((currentState.unfavList ?? {}).cast<int>());
        emit(currentState
            .copyWith(unfavList: {})); // ล้างรายการที่ unfav หลังส่ง API
      } catch (e) {
        emit(FavoriteError(message: "Failed to update favorites"));
      }
    }
  }
}
