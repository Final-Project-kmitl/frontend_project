import 'package:project/features/home/domain/repository/home_repo.dart';

class AddFavorite {
  final HomeRepo homeRepo;
  AddFavorite({required this.homeRepo});

  Future<String> call(int productId) {
    return homeRepo.addFavorite(productId);
  }
}
