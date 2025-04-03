import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/domain/repository/home_repo.dart';

class GetRecent {
  final HomeRepo homeRepo;
  GetRecent({required this.homeRepo});

  Future<List<ProductEntity>> call() async {
    return await homeRepo.recent();
  }
}
