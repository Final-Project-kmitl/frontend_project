import 'package:project/features/auth/domain/repository/ingredient_repository.dart';

class Register {
  final IngredientRepository ingredientRepository;
  Register({required this.ingredientRepository});
  Future<void> call(int userId, String skinType, List<int>? allergicListId,
      List<int> benefitListId) {
    return ingredientRepository.userRegister(
        userId, skinType, allergicListId, benefitListId);
  }
}
