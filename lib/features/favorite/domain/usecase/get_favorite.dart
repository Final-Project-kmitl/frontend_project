import 'package:project/features/favorite/domain/entities/fav_product.dart';
import 'package:project/features/favorite/domain/repository/fav_repository.dart';

class GetFavorite {
  final FavRepository favRepository;
  GetFavorite(this.favRepository);

  Future<List<FavProductEntities>> call() {
    return favRepository.getFavProduct();
  }
}
