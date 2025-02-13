import 'package:get_it/get_it.dart';
import 'package:project/core/network/dio_client.dart';
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
}
