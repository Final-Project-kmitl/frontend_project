import 'package:project/features/favorite/domain/entities/fav_product.dart';

abstract class FavRepository {
  Future<List<FavProductEntities>> getFavProduct();
  Future<void> unFavProduct(Set<int> productId);
}
