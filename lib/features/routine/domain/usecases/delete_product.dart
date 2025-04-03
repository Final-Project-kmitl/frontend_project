import 'package:project/features/routine/domain/repository/routine_repository.dart';

class DeleteProduct {
  final RoutineRepository routineRepository;
  DeleteProduct({required this.routineRepository});

  Future<void> deleteProdcutRoiutine(Set<int> productId) async {
    print("usecase : ${productId}");
    return await routineRepository.deleteProduct(productId);
  }
}
