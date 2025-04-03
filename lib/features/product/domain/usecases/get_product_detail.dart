import 'package:project/features/product/domain/entities/product_entity.dart';
import 'package:project/features/product/domain/repository/product_detail_repository.dart';

class GetProductDetail {
  final ProductDetailRepository productDetailRepository;
  GetProductDetail({required this.productDetailRepository});

  Future<ProductEntity> call(int productId) {
    return productDetailRepository.productDetail(productId);
  }
}
