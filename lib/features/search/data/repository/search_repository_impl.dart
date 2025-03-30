import 'package:project/features/search/data/datasource/search_datasource.dart';
import 'package:project/features/search/domain/entities/auto_complete_entity.dart';
import 'package:project/features/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource searchDatasource;
  SearchRepositoryImpl({required this.searchDatasource});
  @override
  Future<List<AutoCompleteEntity>> searchProduct(String param) {
    return searchDatasource.fetchBySearch(param);
  }
}
