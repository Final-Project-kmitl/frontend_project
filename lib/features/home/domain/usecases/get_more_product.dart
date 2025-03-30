import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/domain/repository/home_repo.dart';

class GetMoreProduct {
  final HomeRepo homeRepo;
  GetMoreProduct({required this.homeRepo});
  Future<List<ProductEntity>> call(int benefitId, int page) {
    return homeRepo.getMoreProduct(benefitId, page);
  }
}
