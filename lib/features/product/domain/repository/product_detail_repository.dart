import 'package:project/features/product/domain/entities/product_entity.dart';

abstract class ProductDetailRepository {
  Future<ProductEntity> productDetail(int productId);
}
