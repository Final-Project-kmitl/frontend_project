import 'package:dartz/dartz.dart';

abstract class SplashApiService {
  Future<Either> chechUserAPI();
}

class SplashApiServiceImpl extends SplashApiService {
  @override
  Future<Either> chechUserAPI() {
    // TODO: implement chechUserAPI
    throw UnimplementedError();
  }
}
