import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/features/home/domain/entities/filter_entity.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/domain/usecases/add_favorite.dart';
import 'package:project/features/home/domain/usecases/get_benefit.dart';
import 'package:project/features/home/domain/usecases/get_favorite.dart';
import 'package:project/features/home/domain/usecases/get_more_product.dart';
import 'package:project/features/home/domain/usecases/get_popular.dart';
import 'package:project/features/home/domain/usecases/get_recent.dart';
import 'package:project/features/home/domain/usecases/get_recomend.dart';
import 'package:project/features/home/domain/usecases/remove_favorite.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRecomend getRecomend;
  final GetRecent getRecent;
  final GetPopular getPopular;
  final GetHomeFavorite getFavorite;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;
  final GetBenefit getBenefit;
  final GetMoreProduct getMoreProduct;

  HomeLoaded? _previousHomeState;

  HomeBloc({
    required this.getPopular,
    required this.getMoreProduct,
    required this.getRecent,
    required this.getRecomend,
    required this.getFavorite,
    required this.addFavorite,
    required this.removeFavorite,
    required this.getBenefit,
  }) : super(HomeLoading()) {
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<LoadRecommendedEvent>(_onLoadRecommended);
    on<LoadPopularEvent>(_onLoadPopular);
    on<LoadRecentEvent>(_onLoadRecent);
    on<LoadFavoriteEvent>(_onLoadFavorite);
    on<LoadByBenefitEvent>(_onByBenefit);
    on<RestoreHomeEvent>(_onRestoreHome);
    on<LoadMoreByBenefitEvent>(_onLoadMoreBenefit);
    on<UpdateUIEvent>(_onUpdateUI);
  }

  void _onUpdateUI(UpdateUIEvent event, Emitter<HomeState> emit) {
    final currentState = state as HomeLoaded;

    final favlist = List<int>.from(currentState.favorite);

    favlist.removeWhere((e) => event.productId == e);

    emit(currentState.copyWith(favorite: favlist));
  }

  Future<void> _onLoadMoreBenefit(
      LoadMoreByBenefitEvent event, Emitter<HomeState> emit) async {
    if (state is HomeBenefitLoaded) {
      final currentState = state as HomeBenefitLoaded;

      // ตั้งค่า isLoadingMore = true เพื่อให้ UI แสดง Loading Text
      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final moreData = await getMoreProduct.call(event.benefitId, event.page);

        print("MORE DATA : $moreData");

        // รวมข้อมูลใหม่เข้ากับของเดิม
        emit(currentState.copyWith(
          allProducts: [...currentState.allProducts, ...moreData],
          isLoadingMore: false,
        ));
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }

  Future<void> _onLoadRecommended(
      LoadRecommendedEvent event, Emitter<HomeState> emit) async {
    try {
      final recommended = await getRecomend();
      final currentState =
          state is HomeLoaded ? state as HomeLoaded : HomeLoaded.empty();

      print("REC : $recommended");

      emit(currentState.copyWith(
          recommended: recommended, isRecommendedLoaded: true));
      print("recco : $currentState");
    } catch (e) {
      print("❌ Error loading recommended: $e");
    }
  }

  Future<void> _onLoadPopular(
      LoadPopularEvent event, Emitter<HomeState> emit) async {
    try {
      final popular = await getPopular();
      final currentState =
          state is HomeLoaded ? state as HomeLoaded : HomeLoaded.empty();

      print("POPULAR : $popular");

      emit(currentState.copyWith(popular: popular, isPopularLoaded: true));
    } catch (e) {
      print("❌ Error loading popular: $e");
    }
  }

  Future<void> _onLoadRecent(
      LoadRecentEvent event, Emitter<HomeState> emit) async {
    try {
      final recent = await getRecent();
      final currentState =
          state is HomeLoaded ? state as HomeLoaded : HomeLoaded.empty();

      print("RECENT : $recent");

      emit(currentState.copyWith(recent: recent, isRecentLoaded: true));
    } catch (e) {
      print("❌ Error loading recent: $e");
    }
  }

  Future<void> _onLoadFavorite(
      LoadFavoriteEvent event, Emitter<HomeState> emit) async {
    try {
      final favorite = await getFavorite();
      final currentState =
          state is HomeLoaded ? state as HomeLoaded : HomeLoaded.empty();

      emit(currentState.copyWith(favorite: favorite, isFavoriteLoaded: true));
      print("fav : $currentState");
    } catch (e) {
      print("❌ Error loading favorite: $e");
    }
  }

  //กดย้อนหลัง
  Future<void> _onRestoreHome(
      RestoreHomeEvent event, Emitter<HomeState> emit) async {
    print("PREVI  : ${_previousHomeState}");
    if (_previousHomeState != null) {
      emit(_previousHomeState!); // ✅ คืนค่าเดิมกลับมา
    } else {
      add(LoadRecommendedEvent()); // ถ้าไม่มีข้อมูลเดิม โหลดใหม่
    }
  }

  Future<void> _onByBenefit(
      LoadByBenefitEvent event, Emitter<HomeState> emit) async {
    final currentState = state;
    try {
      if (currentState is HomeLoaded) {
        _previousHomeState = currentState;
      }

      emit(HomeBenefitLaoding());

      final data = await getBenefit.call(event.benefitId);
      final isFav = await getFavorite.call();

      // ✅ ตรวจสอบว่า Bloc ยังทำงานอยู่ก่อน Emit
      if (emit.isDone) {
        print("⛔ Bloc is closed, skipping emit");
        return;
      }

      print("✅ Emitting HomeBenefitLoaded");
      emit(HomeBenefitLoaded(
        allProducts: data.products,
        products: data.products,
        filter: data.filterCount,
        favorite: isFav,
        isLoadingMore: false,
      ));
    } catch (e) {
      print("❌ BLOC ERROR: ${e.toString()}");
      if (!emit.isDone) {
        emit(HomeError(
            message: e is TimeoutException
                ? e.message ?? "การโหลดข้อมูลใช้เวลานานเกินไป"
                : e.toString()));
      }
    }
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event, Emitter<HomeState> emit) async {
    print("START");
    final currentState = state;

    List<int> updatedFavorites = [];

    if (currentState is HomeLoaded) {
      updatedFavorites = List<int>.from(currentState.favorite);
      if (event.isFavorite) {
        updatedFavorites.remove(event.productId);
      } else {
        updatedFavorites.add(event.productId);
      }
      emit(currentState.copyWith(
          favorite: updatedFavorites)); // ✅ ใช้ copyWith()
    } else if (currentState is HomeBenefitLoaded) {
      updatedFavorites = List<int>.from(currentState.favorite);
      if (event.isFavorite) {
        updatedFavorites.remove(event.productId);
      } else {
        updatedFavorites.add(event.productId);
      }
      emit(currentState.copyWith(
          favorite: updatedFavorites)); // ✅ ใช้ copyWith()
    }

    try {
      if (event.isFavorite) {
        await removeFavorite.call(event.productId);
      } else {
        await addFavorite.call(event.productId);
      }
    } on TimeoutException {
      emit(HomeError(message: "มีข้อผิดพลาด ลองใหม่อีกครั้ง"));
    } catch (e) {
      print("❌ Error updating favorite: $e");
    }
  }
}
