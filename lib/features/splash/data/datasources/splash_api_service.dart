import 'package:dartz/dartz.dart';
import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/error/server_failure.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SplashApiService {
  Future<Either<Failure, bool>> chechUserAPI();

  Future<List<String>> fetchInitalData();
}

class SplashApiServiceImpl extends SplashApiService {
  final userId = sl<SharedPreferences>().getString(shared_pref.userId);
  final dio = sl<DioClient>();

  @override
  Future<Either<Failure, bool>> chechUserAPI() async {
    print("User id : ${userId}");
    try {
      if (userId == "") {
        return Left(ServerFailure("User is null"));
      } else {
        final res = await dio.post("${AppUrl.baseUrl}/auth/authenticate",
            data: {"userId": userId});

        if (res.statusCode == 200) {
          final accessToken = res.data['accessToken'];
          sl<SharedPreferences>().setString("token", accessToken);
          print("TOKEN : ${accessToken}");
          return Right(true);
        }
        return Left(ServerFailure("User not found"));
      }
    } catch (e) {
      return Left(ServerFailure("Error: $e"));
    }
  }

  @override
  Future<List<String>> fetchInitalData() {
    // TODO: implement fetchInitalData
    throw UnimplementedError();
  }
}
