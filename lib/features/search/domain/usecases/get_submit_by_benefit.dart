import 'package:project/features/search/domain/entities/search_entity.dart';
import 'package:project/features/search/domain/repository/submit_by_benefit.dart';

class GetSubmitByBenefit {
  final SubmitByBenefit submitByBenefit;
  GetSubmitByBenefit({required this.submitByBenefit});

  Future<List<ProductEntity>> call(
    String params,
    int page,
    int limit,
    int? minPrice,
    int? maxPrice,
    List<int>? skinTypeIds,
    List<int>? benefitIds,
    List<int>? productTypeIds,
    List<int>? skinProblemIds,
    List<String>? brands,
  ) {
    return submitByBenefit.submitByBenefit(
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
