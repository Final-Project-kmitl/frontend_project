import 'package:project/features/search/domain/entities/count_filter_entity.dart';
import 'package:project/features/search/domain/repository/submit_repository.dart';

class GetSubmit {
  final SubmitRepository submitRepository;
  GetSubmit({required this.submitRepository});

  Future<SubmitReturnEntity> call(
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
    return submitRepository.getOnSubmit(
      params,
      page,
      limit,
      minPrice != null ? minPrice : null,
      maxPrice != null ? maxPrice : null,
      (skinTypeIds != null && skinTypeIds.isNotEmpty) ? skinTypeIds : null,
      (benefitIds != null && benefitIds.isNotEmpty) ? benefitIds : null,
      (productTypeIds != null && productTypeIds.isNotEmpty)
          ? productTypeIds
          : null,
      (skinProblemIds != null && skinProblemIds.isNotEmpty)
          ? skinProblemIds
          : null,
      (brands != null && brands.isNotEmpty) ? brands : null,
    );
  }
}
