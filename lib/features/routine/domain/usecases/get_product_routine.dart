import 'package:project/features/routine/domain/entities/product_entity.dart';
import 'package:project/features/routine/domain/repository/routine_repository.dart';

class GetProductRoutine {
  final RoutineRepository routineRepository;
  GetProductRoutine({required this.routineRepository});

  Future<List<ProductEntity>> call() async {
    return await routineRepository.getProductRoutine();
  }
}
