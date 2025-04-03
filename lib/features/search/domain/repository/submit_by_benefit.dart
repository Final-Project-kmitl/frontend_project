import '../entities/search_entity.dart';

abstract class SubmitByBenefit {
  Future<List<ProductEntity>> submitByBenefit(
      String params,
      int page,
      int limit,
      int? minPrice,
      int? maxPrice,
      List<int>? skinTypeIds,
      List<int>? benefitIds,
      List<int>? productTypeIds,
      List<int>? skinProblemIds,
      List<String>? brands);
}
