import 'package:project/features/routine/data/datasource/routine_datasource.dart';
import 'package:project/features/routine/domain/entities/no_match_entity.dart';
import 'package:project/features/routine/domain/entities/product_entity.dart';
import 'package:project/features/routine/domain/repository/routine_repository.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final RoutineRemoteDatasource routineRemoteDatasource;

  RoutineRepositoryImpl({required this.routineRemoteDatasource});
  @override
  Future<List<NoMatchEntity>> getNoMatchRoutine() async {
    return await routineRemoteDatasource.fetchNoMatchRoutine();
  }

  @override
  Future<List<ProductEntity>> getProductRoutine() async {
    return await routineRemoteDatasource.fetchProductRoutine();
  }

  @override
  Future<void> deleteProduct(Set<int> productId) async {
    print("repo : ${productId}");
    return await routineRemoteDatasource.deleteProduct(productId);
  }

  @override
  Future<Map<String, dynamic>> getQuery(String query) async {
    return await routineRemoteDatasource.queryProduct(query);
  }

  @override
  Future<List<ProductEntity>> getMoreQuery(String query, int page) async {
    return await routineRemoteDatasource.queryMoreProduct(page, query);
  }

  @override
  Future<void> addRoutine(int productId) async {
    return await routineRemoteDatasource.addProduct(productId);
  }
}
