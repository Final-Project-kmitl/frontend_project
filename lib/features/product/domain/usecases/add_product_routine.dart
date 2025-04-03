import 'package:project/features/product/domain/repository/product_detail_repository.dart';

class AddProductRoutine {
  final ProductDetailRepository productDetailRepository;
  AddProductRoutine({required this.productDetailRepository});
  Future<void> call(int productId) {
    return productDetailRepository.addRoutineProduct(productId);
  }
}
