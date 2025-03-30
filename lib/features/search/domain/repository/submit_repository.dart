import 'package:project/features/search/domain/entities/count_filter_entity.dart';

abstract class SubmitRepository {
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
      List<String>? brands);
}
