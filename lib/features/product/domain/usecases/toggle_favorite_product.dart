import 'package:project/features/product/domain/repository/product_detail_repository.dart';

class ToggleFavoriteProduct {
  final ProductDetailRepository productDetailRepository;
  ToggleFavoriteProduct({required this.productDetailRepository});

  Future<void> call(int productId, bool isFav) async {
    print("ISFAV : ${isFav}");
    try {
      if (isFav) {
        await productDetailRepository.removeFavoriteProduct(productId);
      } else {
        await productDetailRepository.addFavoriteProduct(productId);
      }
    } catch (e) {
      throw Exception("Failed to update favorite: ${e.toString()}");
    }
  }
}
