import 'package:dartz/dartz.dart';
import 'package:project/core/error/server_failure.dart';
import 'package:project/features/splash/domain/repository/splash_repository.dart';

class CheckUser {
  final SplashRepository splashRepository;
  CheckUser({required this.splashRepository});
  Future<Either<Failure, bool>> call() async {
    return await splashRepository.checkUser();
  }
}
