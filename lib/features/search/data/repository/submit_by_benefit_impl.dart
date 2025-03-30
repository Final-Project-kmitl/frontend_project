import 'package:project/features/search/data/datasource/search_datasource.dart';
import 'package:project/features/search/domain/entities/search_entity.dart';
import 'package:project/features/search/domain/repository/submit_by_benefit.dart';

class SubmitByBenefitImpl implements SubmitByBenefit {
  final SearchDatasource searchDatasource;
  SubmitByBenefitImpl({required this.searchDatasource});
  @override
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
      List<String>? brands) {
    return searchDatasource.getSearchBybenefit(
        params,
        page,
        limit,
        minPrice,
        maxPrice,
        skinTypeIds,
        benefitIds,
        productTypeIds,
        skinProblemIds,
        brands);
  }
}
