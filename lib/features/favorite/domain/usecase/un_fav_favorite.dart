import 'package:project/features/favorite/domain/repository/fav_repository.dart';

class UnFavFavorite {
  final FavRepository favRepository;
  UnFavFavorite(this.favRepository);

  Future<void> call(Set<int> unfavId) {
    print("usecase");
    return favRepository.unFavProduct(unfavId);
  }
}
