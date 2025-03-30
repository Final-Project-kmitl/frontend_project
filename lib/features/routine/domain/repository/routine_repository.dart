import 'package:project/features/routine/domain/entities/no_match_entity.dart';
import 'package:project/features/routine/domain/entities/product_entity.dart';

abstract class RoutineRepository {
  Future<List<ProductEntity>> getProductRoutine();

  Future<List<NoMatchEntity>> getNoMatchRoutine();

  Future<void> deleteProduct(Set<int> productId);

  Future<Map<String, dynamic>> getQuery(String query);

  Future<List<ProductEntity>> getMoreQuery(String query, int page);

  Future<void> addRoutine(int productId);
}
