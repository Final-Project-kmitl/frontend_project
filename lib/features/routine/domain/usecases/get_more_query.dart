import 'package:project/features/routine/domain/entities/product_entity.dart';
import 'package:project/features/routine/domain/repository/routine_repository.dart';

class GetMoreQuery {
  final RoutineRepository routineRepository;
  GetMoreQuery({required this.routineRepository});

  Future<List<ProductEntity>> call({required int page, required String query}) {
    return routineRepository.getMoreQuery(query, page);
  }
}
