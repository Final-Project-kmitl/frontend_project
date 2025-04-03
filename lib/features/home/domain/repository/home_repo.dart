import 'package:project/features/home/domain/entities/filter_entity.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';

abstract class HomeRepo {
  Future<List<ProductEntity>> recommend();
  Future<List<ProductEntity>> popular();
  Future<List<ProductEntity>> recent();
  Future<List<int>> favorite();
  Future<String> addFavorite(int productId);
  Future<String> removeFavorite(int productId);
  Future<MergeReturnFilterByBenefitEntity> getProductByBenefit(int benefitId);
  Future<List<ProductEntity>> getMoreProduct(int benefitId, int page);
}
