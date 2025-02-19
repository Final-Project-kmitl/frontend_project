import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/domain/usecases/add_favorite.dart';
import 'package:project/features/home/domain/usecases/get_favorite.dart';
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

  HomeBloc({
    required this.getPopular,
    required this.getRecent,
    required this.getRecomend,
    required this.getFavorite,
    required this.addFavorite,
    required this.removeFavorite,
  }) : super(HomeLoading()) {
    on<HomeDataRequestedEvent>(_onHomeDataRequested);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event, Emitter<HomeState> emit) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final updatedFavorites =
          List<FavoriteProductEntity>.from(currentState.favorite);

      try {
        if (event.isFavorite) {
          await removeFavorite.call(event.productFav.id);
          updatedFavorites.removeWhere((fav) => fav.id == event.productFav.id);
        } else {
          await addFavorite.call(event.productFav.id);
          updatedFavorites.add(FavoriteProductEntity(
            brand: event.productFav.brand,
            id: event.productFav.id,
            image_url: event.productFav.image_url,
            max_price: event.productFav.max_price,
            min_price: event.productFav.min_price,
            name: event.productFav.name,
            view: event.productFav.view,
          ));
        }

        emit(currentState.copyWith(favorite: updatedFavorites));
      } catch (e) {
        print("❌ Error updating favorite: $e");
      }
    }
  }

  Future<void> _onHomeDataRequested(
      HomeDataRequestedEvent event, Emitter<HomeState> emit) async {
    if (state is! HomeLoading) {
      emit(HomeLoading());
    }

    try {
      late var recommended;
      late var popular;
      late var recent;
      late var fav;

      try {
        recommended = await getRecomend.call();
      } catch (e) {
        recommended = [];
        print("⚠️ Error loading recommended: $e");
      }

      try {
        popular = await getPopular.call();
      } catch (e) {
        popular = [];
        print("⚠️ Error loading popular: $e");
      }

      try {
        recent = await getRecent.call();
      } catch (e) {
        recent = [];
        print("⚠️ Error loading recent: $e");
      }

      try {
        fav = await getFavorite.call();
      } catch (e) {
        fav = [];
        print("⚠️ Error loading favorite: $e");
      }

      emit(HomeLoaded(
        recommended: recommended,
        popular: popular,
        recent: recent,
        favorite: fav,
      ));
    } catch (e, stacktrace) {
      print("❌ HomeBloc Error: $e");
      print(stacktrace);
      emit(HomeError(message: "เกิดข้อผิดพลาดในการโหลดข้อมูล"));
    }
  }
}
