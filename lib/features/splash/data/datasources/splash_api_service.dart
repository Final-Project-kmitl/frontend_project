import 'package:dartz/dartz.dart';
import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/error/server_failure.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SplashApiService {
  Future<Either<Failure, bool>> chechUserAPI();
}

class SplashApiServiceImpl extends SplashApiService {
  final userId = sl<SharedPreferences>().getString(shared_pref.userId);
  final dio = sl<DioClient>();

  @override
  Future<Either<Failure, bool>> chechUserAPI() async {
    print("User id : ${userId}");
    try {
      if (userId == null) {
        return Left(ServerFailure("User is null"));
      } else {
        final res = await dio.get("${AppUrl.baseUrl}/user/$userId");

        if (res.statusCode == 200) {
          print(res.statusCode);
          return Right(true);
        }
        return Left(ServerFailure("User not found"));
      }
    } catch (e) {
      return Left(ServerFailure("Error: $e"));
    }
  }
}
