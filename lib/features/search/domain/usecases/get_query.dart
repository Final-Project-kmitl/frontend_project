import 'package:project/features/search/domain/entities/auto_complete_entity.dart';
import 'package:project/features/search/domain/repository/search_repository.dart';

class GetQuery {
  final SearchRepository searchRepository;
  GetQuery({required this.searchRepository});

  Future<List<AutoCompleteEntity>> call(String param) {
    return searchRepository.searchProduct(param);
  }
}
