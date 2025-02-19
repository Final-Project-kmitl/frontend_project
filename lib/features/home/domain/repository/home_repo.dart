import 'package:project/features/home/domain/entities/product_entity.dart';

abstract class HomeRepo {
  Future<List<ProductEntity>> recommend();
  Future<List<ProductEntity>> popular();
  Future<List<ProductEntity>> recent();
  Future<List<FavoriteProductEntity>> favorite();
  Future<String> addFavorite(int productId);
  Future<String> removeFavorite(int productId);
}
