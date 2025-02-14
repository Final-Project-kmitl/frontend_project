import 'package:get_it/get_it.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/favorite/data/datasource/fav_datasource.dart';
import 'package:project/features/favorite/data/repository/fav_repository_impl.dart';
import 'package:project/features/favorite/domain/repository/fav_repository.dart';
import 'package:project/features/favorite/domain/usecase/get_favorite.dart';
import 'package:project/features/favorite/domain/usecase/un_fav_favorite.dart';
import 'package:project/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:project/features/routine/data/datasource/routine_datasource.dart';
import 'package:project/features/routine/data/repository/routine_repository_impl.dart';
import 'package:project/features/routine/domain/repository/routine_repository.dart';
import 'package:project/features/routine/domain/usecases/get_no_match_routine.dart';
import 'package:project/features/routine/domain/usecases/get_product_routine.dart';
import 'package:project/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void setupServiceLocator() async {
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());

  await sl.allReady();

//Routine
  sl.registerLazySingleton<RoutineRemoteDatasource>(() => apiServiceRoutine());
  sl.registerLazySingleton<RoutineRepository>(() => RoutineRepositoryImpl(
      routineRemoteDatasource: sl<RoutineRemoteDatasource>()));
  sl.registerLazySingleton<GetNoMatchRoutine>(
      () => GetNoMatchRoutine(routineRepository: sl<RoutineRepository>()));
  sl.registerLazySingleton<GetProductRoutine>(
      () => GetProductRoutine(routineRepository: sl<RoutineRepository>()));
  sl.registerFactory<RoutineBloc>(() => RoutineBloc(
      getNoMatchRoutine: sl<GetNoMatchRoutine>(),
      getProductRoutine: sl<GetProductRoutine>()));

  //Favorite
  sl.registerLazySingleton<FavRemoteDatasource>(() => apiServiceFavorite());
  sl.registerLazySingleton<FavRepository>(
      () => FavRepositoryImpl(sl<FavRemoteDatasource>()));
  sl.registerLazySingleton<GetFavorite>(() => GetFavorite(sl<FavRepository>()));
  sl.registerLazySingleton<UnFavFavorite>(
      () => UnFavFavorite(sl<FavRepository>()));
  sl.registerFactory<FavoriteBloc>(() => FavoriteBloc(sl<FavRepository>()));
}
