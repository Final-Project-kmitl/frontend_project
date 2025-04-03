import 'package:project/features/favorite/data/datasource/fav_datasource.dart';
import 'package:project/features/favorite/domain/entities/fav_product.dart';
import 'package:project/features/favorite/domain/repository/fav_repository.dart';

class FavRepositoryImpl implements FavRepository {
  final FavRemoteDatasource favRemoteDatasource;

  FavRepositoryImpl(this.favRemoteDatasource);
  @override
  Future<List<FavProductEntities>> getFavProduct() async {
    return await favRemoteDatasource.fetchFavProduct();
  }

  @override
  Future<void> unFavProduct(Set<int> productId) async {
    return await favRemoteDatasource.unFavProduct(productId);
  }
}
