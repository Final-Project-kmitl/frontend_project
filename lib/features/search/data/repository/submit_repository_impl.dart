import 'package:project/features/search/data/datasource/search_datasource.dart';
import 'package:project/features/search/domain/entities/count_filter_entity.dart';
import 'package:project/features/search/domain/repository/submit_repository.dart';

class SubmitRepositoryImpl implements SubmitRepository {
  final SearchDatasource searchDatasource;

  SubmitRepositoryImpl({required this.searchDatasource});
  @override
  Future<SubmitReturnEntity> getOnSubmit(
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
    return searchDatasource.getCountFilter(
        params,
        page,
        limit,
        minPrice,
        minPrice,
        skinTypeIds,
        benefitIds,
        productTypeIds,
        skinProblemIds,
        brands);
  }
}
