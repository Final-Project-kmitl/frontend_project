import 'package:project/features/product/data/datasource/product_datasource.dart';
import 'package:project/features/product/domain/entities/product_entity.dart';
import 'package:project/features/product/domain/repository/product_detail_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDatasource productDatasource;
  ProductDetailRepositoryImpl({required this.productDatasource});
  @override
  Future<ProductEntity> productDetail(int productId) async {
    return await productDatasource.fetchProduct(productId);
  }
}
