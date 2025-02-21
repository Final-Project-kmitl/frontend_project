import 'package:get_it/get_it.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/favorite/data/datasource/fav_datasource.dart';
import 'package:project/features/favorite/data/repository/fav_repository_impl.dart';
import 'package:project/features/favorite/domain/repository/fav_repository.dart';
import 'package:project/features/favorite/domain/usecase/get_favorite.dart';
import 'package:project/features/favorite/domain/usecase/un_fav_favorite.dart';
import 'package:project/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:project/features/home/data/datasource/home_datasource.dart';
import 'package:project/features/home/data/repository/home_repo_impl.dart';
import 'package:project/features/home/domain/repository/home_repo.dart';
import 'package:project/features/home/domain/usecases/add_favorite.dart';
import 'package:project/features/home/domain/usecases/get_favorite.dart';
import 'package:project/features/home/domain/usecases/get_popular.dart';
import 'package:project/features/home/domain/usecases/get_recent.dart';
import 'package:project/features/home/domain/usecases/get_recomend.dart';
import 'package:project/features/home/domain/usecases/remove_favorite.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/features/product/data/datasource/product_datasource.dart';
import 'package:project/features/product/data/repository/product_detail_repository_impl.dart';
import 'package:project/features/product/domain/repository/product_detail_repository.dart';
import 'package:project/features/product/domain/usecases/get_product_detail.dart';
import 'package:project/features/product/presentation/bloc/product_bloc.dart';
import 'package:project/features/routine/data/datasource/routine_datasource.dart';
import 'package:project/features/routine/data/repository/routine_repository_impl.dart';
import 'package:project/features/routine/domain/repository/routine_repository.dart';
import 'package:project/features/routine/domain/usecases/delete_product.dart';
import 'package:project/features/routine/domain/usecases/get_no_match_routine.dart';
import 'package:project/features/routine/domain/usecases/get_product_routine.dart';
import 'package:project/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:project/features/splash/data/datasources/splash_api_service.dart';
import 'package:project/features/splash/data/repository/splash_repository_impl.dart';
import 'package:project/features/splash/domain/repository/splash_repository.dart';
import 'package:project/features/splash/domain/usecases/check_user.dart';
import 'package:project/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());

  await sl.allReady();
  sl<SharedPreferences>().setString(shared_pref.userId, "1");

//Routine
  sl.registerLazySingleton<RoutineRemoteDatasource>(() => apiServiceRoutine());
  sl.registerLazySingleton<RoutineRepository>(() => RoutineRepositoryImpl(
      routineRemoteDatasource: sl<RoutineRemoteDatasource>()));
  sl.registerLazySingleton<GetNoMatchRoutine>(
      () => GetNoMatchRoutine(routineRepository: sl<RoutineRepository>()));
  sl.registerLazySingleton<GetProductRoutine>(
      () => GetProductRoutine(routineRepository: sl<RoutineRepository>()));
  sl.registerLazySingleton<DeleteProduct>(
      () => DeleteProduct(routineRepository: sl<RoutineRepository>()));
  sl.registerFactory<RoutineBloc>(() => RoutineBloc(
      deleteProduct: sl<DeleteProduct>(),
      getNoMatchRoutine: sl<GetNoMatchRoutine>(),
      getProductRoutine: sl<GetProductRoutine>()));

  //Favorite
  sl.registerLazySingleton<FavRemoteDatasource>(() => apiServiceFavorite());
  sl.registerLazySingleton<FavRepository>(
      () => FavRepositoryImpl(sl<FavRemoteDatasource>()));
  sl.registerLazySingleton<GetFavorite>(
      () => GetFavorite(favRepository: sl<FavRepository>()));
  sl.registerLazySingleton<UnFavFavorite>(
      () => UnFavFavorite(sl<FavRepository>()));
  sl.registerLazySingleton<FavoriteBloc>(() => FavoriteBloc(
        getFavorite: sl<GetFavorite>(),
        unFavFavorite: sl<UnFavFavorite>(),
      ));

  //Home
  sl.registerLazySingleton<HomeRemoteDatasource>(() => apiServiceHome());
  sl.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(homeRemoteDatasource: sl<HomeRemoteDatasource>()));
  sl.registerLazySingleton<GetPopular>(
      () => GetPopular(homeRepo: sl<HomeRepo>()));
  sl.registerLazySingleton<GetRecent>(
      () => GetRecent(homeRepo: sl<HomeRepo>()));
  sl.registerLazySingleton<GetRecomend>(
      () => GetRecomend(homeRepo: sl<HomeRepo>()));
  sl.registerLazySingleton<GetHomeFavorite>(
      () => GetHomeFavorite(homeRepo: sl<HomeRepo>()));
  sl.registerLazySingleton<AddFavorite>(
      () => AddFavorite(homeRepo: sl<HomeRepo>()));
  sl.registerLazySingleton<RemoveFavorite>(
      () => RemoveFavorite(homeRepo: sl<HomeRepo>()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(
        getPopular: sl<GetPopular>(),
        getRecent: sl<GetRecent>(),
        getRecomend: sl<GetRecomend>(),
        getFavorite: sl<GetHomeFavorite>(),
        addFavorite: sl<AddFavorite>(),
        removeFavorite: sl<RemoveFavorite>(),
      ));

  //Product
  sl.registerLazySingleton<ProductDatasource>(() => apiServiceProduct());
  sl.registerLazySingleton<ProductDetailRepository>(() =>
      ProductDetailRepositoryImpl(productDatasource: sl<ProductDatasource>()));
  sl.registerLazySingleton<GetProductDetail>(() =>
      GetProductDetail(productDetailRepository: sl<ProductDetailRepository>()));
  sl.registerFactory<ProductBloc>(
      () => ProductBloc(getProductDetail: sl<GetProductDetail>()));

  //Splash
  sl.registerLazySingleton<SplashApiService>(() => SplashApiServiceImpl());
  sl.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(splashApiService: sl<SplashApiService>()));
  sl.registerLazySingleton<CheckUser>(
      () => CheckUser(splashRepository: sl<SplashRepository>()));
  sl.registerFactory<SplashBloc>(() => SplashBloc(checkUser: sl<CheckUser>()));
}
