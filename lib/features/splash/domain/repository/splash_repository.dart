import 'package:dartz/dartz.dart';
import 'package:project/core/error/server_failure.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool>> checkUser();
}
