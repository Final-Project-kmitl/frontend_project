import 'package:project/features/home/domain/entities/filter_entity.dart';
import 'package:project/features/home/domain/repository/home_repo.dart';

class GetBenefit {
  final HomeRepo homeRepo;

  GetBenefit({required this.homeRepo});

  Future<MergeReturnFilterByBenefitEntity> call(int benefitId) {
    return homeRepo.getProductByBenefit(benefitId);
  }
}
