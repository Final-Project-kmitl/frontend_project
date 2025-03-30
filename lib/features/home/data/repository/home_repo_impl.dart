import 'package:project/features/home/data/datasource/home_datasource.dart';
import 'package:project/features/home/domain/entities/filter_entity.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/domain/repository/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepoImpl({required this.homeRemoteDatasource});
  @override
  Future<List<ProductEntity>> popular() async {
    return await homeRemoteDatasource.fetchPopular();
  }

  @override
  Future<List<ProductEntity>> recent() async {
    return await homeRemoteDatasource.fetchRecent();
  }

  @override
  Future<List<ProductEntity>> recommend() async {
    return await homeRemoteDatasource.fetchRecommend();
  }

  @override
  Future<List<int>> favorite() async {
    return await homeRemoteDatasource.fetchFavProduct();
  }

  @override
  Future<String> addFavorite(int productId) async {
    return await homeRemoteDatasource.addFavorite(productId);
  }

  @override
  Future<String> removeFavorite(int productId) async {
    return await homeRemoteDatasource.removeFavorite(productId);
  }

  @override
  Future<MergeReturnFilterByBenefitEntity> getProductByBenefit(
      int benefitId) async {
    return await homeRemoteDatasource.fetchByBenefitId(benefitId);
  }

  @override
  Future<List<ProductEntity>> getMoreProduct(int benefitId, int page) async {
    return await homeRemoteDatasource.fetchMoreProduct(benefitId, page);
  }
}
