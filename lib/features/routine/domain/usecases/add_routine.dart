import 'package:project/features/routine/domain/repository/routine_repository.dart';

class AddRoutine {
  final RoutineRepository routineRepository;
  AddRoutine({required this.routineRepository});

  Future<void> call(int productId) {
    return routineRepository.addRoutine(productId);
  }
}
