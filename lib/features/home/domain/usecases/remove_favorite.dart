import 'package:project/features/home/domain/repository/home_repo.dart';

class RemoveFavorite {
  final HomeRepo homeRepo;
  RemoveFavorite({required this.homeRepo});

  Future<String> call(int productId) {
    return homeRepo.removeFavorite(productId);
  }
}
