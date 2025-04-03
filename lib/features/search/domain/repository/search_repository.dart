import 'package:project/features/search/domain/entities/auto_complete_entity.dart';


abstract class SearchRepository {
  Future<List<AutoCompleteEntity>> searchProduct(String param);
}
