import 'package:get_it/get_it.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/auth/data/datasource/search_ingredient.dart';
import 'package:project/features/auth/data/repository/ingredient_repo_impl.dart';
import 'package:project/features/auth/domain/repository/ingredient_repository.dart';
import 'package:project/features/auth/domain/usecases/get_auth_ingredient.dart';
import 'package:project/features/auth/domain/usecases/register.dart';
import 'package:project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:project/features/camera/data/datasource/camera_datasource.dart';
import 'package:project/features/camera/data/repository/camera_repository_impl.dart';
import 'package:project/features/camera/domain/repository/camera_repository.dart';
import 'package:project/features/camera/domain/usecases/getProduct.dart';
import 'package:project/features/camera/domain/usecases/getProductByPhoto.dart';
import 'package:project/features/camera/presentation/bloc/camera_bloc.dart';
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
import 'package:project/features/home/domain/usecases/get_benefit.dart';
import 'package:project/features/home/domain/usecases/get_favorite.dart';
import 'package:project/features/home/domain/usecases/get_more_product.dart';
import 'package:project/features/home/domain/usecases/get_popular.dart';
import 'package:project/features/home/domain/usecases/get_recent.dart';
import 'package:project/features/home/domain/usecases/get_recomend.dart';
import 'package:project/features/home/domain/usecases/remove_favorite.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/features/product/data/datasource/product_datasource.dart';
import 'package:project/features/product/data/repository/product_detail_repository_impl.dart';
import 'package:project/features/product/domain/repository/product_detail_repository.dart';
import 'package:project/features/product/domain/usecases/add_product_routine.dart';
import 'package:project/features/product/domain/usecases/get_product_detail.dart';
import 'package:project/features/product/domain/usecases/toggle_favorite_product.dart';
import 'package:project/features/product/presentation/bloc/product_bloc.dart';
import 'package:project/features/profile/data/datasource/user_datasource.dart';
import 'package:project/features/profile/data/repository/user_repository_impl.dart';
import 'package:project/features/profile/domain/repository/user_repository.dart';
import 'package:project/features/profile/domain/usecases/get_query_text.dart';
import 'package:project/features/profile/domain/usecases/get_user_info.dart';
import 'package:project/features/profile/domain/usecases/skin_problem.dart';
import 'package:project/features/profile/domain/usecases/update_allergic.dart';
import 'package:project/features/profile/domain/usecases/update_skin_type.dart';
import 'package:project/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:project/features/routine/data/datasource/routine_datasource.dart';
import 'package:project/features/routine/data/repository/routine_repository_impl.dart';
import 'package:project/features/routine/domain/repository/routine_repository.dart';
import 'package:project/features/routine/domain/usecases/add_routine.dart';
import 'package:project/features/routine/domain/usecases/delete_product.dart';
import 'package:project/features/routine/domain/usecases/get_more_query.dart';
import 'package:project/features/routine/domain/usecases/get_no_match_routine.dart';
import 'package:project/features/routine/domain/usecases/get_product_routine.dart';
import 'package:project/features/routine/domain/usecases/get_query.dart';
import 'package:project/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:project/features/search/data/datasource/search_datasource.dart';
import 'package:project/features/search/data/repository/search_repository_impl.dart';
import 'package:project/features/search/data/repository/submit_by_benefit_impl.dart';
import 'package:project/features/search/data/repository/submit_repository_impl.dart';
import 'package:project/features/search/domain/repository/search_repository.dart';
import 'package:project/features/search/domain/repository/submit_by_benefit.dart';
import 'package:project/features/search/domain/repository/submit_repository.dart';
import 'package:project/features/search/domain/usecases/get_query.dart';
import 'package:project/features/search/domain/usecases/get_submit.dart';
import 'package:project/features/search/domain/usecases/get_submit_by_benefit.dart';
import 'package:project/features/search/presentation/bloc/search_bloc.dart';
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
  // sl<SharedPreferences>().setString(shared_pref.userId, "1");
  sl<SharedPreferences>().setBool("doNotShowAgain", false);
  sl<SharedPreferences>().setStringList("recent", ["Cerave", "namo", "bhudda"]);
  sl<SharedPreferences>().setStringList("page", []);

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
  sl.registerLazySingleton<GetQueryRoutine>(
      () => GetQueryRoutine(routineRepository: sl<RoutineRepository>()));
  sl.registerLazySingleton<GetMoreQuery>(
      () => GetMoreQuery(routineRepository: sl<RoutineRepository>()));
  sl.registerLazySingleton<AddRoutine>(
      () => AddRoutine(routineRepository: sl<RoutineRepository>()));
  sl.registerFactory<RoutineBloc>(() => RoutineBloc(
      deleteProduct: sl<DeleteProduct>(),
      getNoMatchRoutine: sl<GetNoMatchRoutine>(),
      getProductRoutine: sl<GetProductRoutine>(),
      getQuery: sl<GetQueryRoutine>(),
      getMoreQuery: sl<GetMoreQuery>(),
      addRoutine: sl<AddRoutine>()));

  //search
  sl.registerLazySingleton<SearchDatasource>(() => apiService());
  sl.registerLazySingleton<SubmitRepository>(
      () => SubmitRepositoryImpl(searchDatasource: sl<SearchDatasource>()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(searchDatasource: sl<SearchDatasource>()));
  sl.registerLazySingleton<SubmitByBenefit>(
      () => SubmitByBenefitImpl(searchDatasource: sl<SearchDatasource>()));
  sl.registerLazySingleton<GetSubmit>(
      () => GetSubmit(submitRepository: sl<SubmitRepository>()));
  sl.registerLazySingleton<GetQuery>(
      () => GetQuery(searchRepository: sl<SearchRepository>()));
  sl.registerLazySingleton<GetSubmitByBenefit>(
      () => GetSubmitByBenefit(submitByBenefit: sl<SubmitByBenefit>()));
  sl.registerLazySingleton<SearchBloc>(() => SearchBloc(
      getQuery: sl<GetQuery>(),
      getSubmit: sl<GetSubmit>(),
      getSubmitByBenefit: sl<GetSubmitByBenefit>()));

  //Profile
  sl.registerLazySingleton<UserDatasource>(() => ApiServiceUser());
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(sl<UserDatasource>()));
  sl.registerLazySingleton<GetUserInfo>(
      () => GetUserInfo(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<UpdateAllergic>(
      () => UpdateAllergic(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<SkinProblem>(
      () => SkinProblem(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<GetQueryText>(
      () => GetQueryText(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<UpdateSkinType>(
      () => UpdateSkinType(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<ProfileBloc>(() => ProfileBloc(
      getUserInfo: sl<GetUserInfo>(),
      getQueryText: sl<GetQueryText>(),
      updateAllergic: sl<UpdateAllergic>(),
      skinProblem: sl<SkinProblem>(),
      updateSkinType: sl<UpdateSkinType>()));

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
        homeBloc: sl<HomeBloc>(),
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
  sl.registerLazySingleton<GetBenefit>(
      () => GetBenefit(homeRepo: sl<HomeRepo>()));
  sl.registerLazySingleton<GetMoreProduct>(
      () => GetMoreProduct(homeRepo: sl<HomeRepo>()));
  sl.registerLazySingleton<HomeBloc>(() => HomeBloc(
        getPopular: sl<GetPopular>(),
        getRecent: sl<GetRecent>(),
        getRecomend: sl<GetRecomend>(),
        getFavorite: sl<GetHomeFavorite>(),
        addFavorite: sl<AddFavorite>(),
        removeFavorite: sl<RemoveFavorite>(),
        getBenefit: sl<GetBenefit>(),
        getMoreProduct: sl<GetMoreProduct>(),
      ));

  //Product
  sl.registerLazySingleton<ProductDatasource>(() => apiServiceProduct());
  sl.registerLazySingleton<ProductDetailRepository>(() =>
      ProductDetailRepositoryImpl(productDatasource: sl<ProductDatasource>()));
  sl.registerLazySingleton<GetProductDetail>(() =>
      GetProductDetail(productDetailRepository: sl<ProductDetailRepository>()));
  sl.registerLazySingleton<ToggleFavoriteProduct>(() => ToggleFavoriteProduct(
      productDetailRepository: sl<ProductDetailRepository>()));
  sl.registerLazySingleton<AddProductRoutine>(() => AddProductRoutine(
      productDetailRepository: sl<ProductDetailRepository>()));
  sl.registerFactory<ProductBloc>(
    () => ProductBloc(
      getProductDetail: sl<GetProductDetail>(),
      toggleFavoriteProduct: sl<ToggleFavoriteProduct>(),
      homeBloc: sl<HomeBloc>(),
      addProductRoutine: sl<AddProductRoutine>(),
    ),
  );

  //Camera
  sl.registerLazySingleton<CameraDatasource>(() => apiServiceCamera());
  sl.registerLazySingleton<CameraRepository>(
      () => CameraRepositoryImpl(cameraDatasource: sl<CameraDatasource>()));
  sl.registerLazySingleton<Getproduct>(
      () => Getproduct(cameraRepository: sl<CameraRepository>()));
  sl.registerLazySingleton<Getproductbyphoto>(
      () => Getproductbyphoto(cameraRepository: sl<CameraRepository>()));
  sl.registerFactory(
    () => CameraBloc(
      getproduct: sl<Getproduct>(),
      getproductbyphoto: sl<Getproductbyphoto>(),
    ),
  );

  //Auth
  sl.registerLazySingleton<AuthApiService>(() => apiServiceAuth());
  sl.registerLazySingleton<IngredientRepository>(
      () => IngredientRepoImpl(authApiService: sl<AuthApiService>()));
  sl.registerLazySingleton<GetAuthIngredient>(() =>
      GetAuthIngredient(ingredientRepository: sl<IngredientRepository>()));
  sl.registerLazySingleton<Register>(
      () => Register(ingredientRepository: sl<IngredientRepository>()));
  sl.registerFactory(() => AuthBloc(
      getAuthIngredient: sl<GetAuthIngredient>(), register: sl<Register>()));

  //Splash
  sl.registerLazySingleton<SplashApiService>(() => SplashApiServiceImpl());
  sl.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(splashApiService: sl<SplashApiService>()));
  sl.registerLazySingleton<CheckUser>(
      () => CheckUser(splashRepository: sl<SplashRepository>()));
  sl.registerFactory<SplashBloc>(() => SplashBloc(checkUser: sl<CheckUser>()));
}
