import 'package:project/features/product/domain/entities/product_entity.dart';

abstract class ProductDetailRepository {
  Future<ProductEntity> productDetail(int productId);
  Future<void> addFavoriteProduct(int productId);
  Future<void> removeFavoriteProduct(int productId);
  Future<void> addRoutineProduct(int productId);
}
