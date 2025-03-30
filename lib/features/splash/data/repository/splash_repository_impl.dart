import 'package:dartz/dartz.dart';
import 'package:project/core/error/server_failure.dart';
import 'package:project/features/splash/data/datasources/splash_api_service.dart';
import 'package:project/features/splash/domain/repository/splash_repository.dart';

class SplashRepositoryImpl extends SplashRepository {
  SplashApiService splashApiService;
  SplashRepositoryImpl({required this.splashApiService});

  @override
  Future<Either<Failure, bool>> checkUser() async {
    return await splashApiService.chechUserAPI();
  }
  
  @override
  Future<List<String>> getInitialData() {
    // TODO: implement getInitialData
    throw UnimplementedError();
  }
}
