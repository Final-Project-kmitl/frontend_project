import 'package:project/features/routine/domain/entities/no_match_entity.dart';
import 'package:project/features/routine/domain/repository/routine_repository.dart';

class GetNoMatchRoutine {
  final RoutineRepository routineRepository;

  GetNoMatchRoutine({required this.routineRepository});

  Future<List<NoMatchEntity>> call() async {
    return await routineRepository.getNoMatchRoutine();
  }
}
