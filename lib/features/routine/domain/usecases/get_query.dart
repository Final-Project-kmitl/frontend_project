import 'package:project/features/routine/domain/entities/product_entity.dart';
import 'package:project/features/routine/domain/repository/routine_repository.dart';

class GetQueryRoutine {
  final RoutineRepository routineRepository;

  GetQueryRoutine({required this.routineRepository});

  Future<Map<String, dynamic>> call(String query) {
    return routineRepository.getQuery(query);
  }
}
