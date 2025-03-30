import 'package:project/features/auth/domain/entities/ingredient_entity.dart';

abstract class IngredientRepository {
  Future<List<IngredientEntity>> fetchingredient(String ingredient);
  Future<void> userRegister(int userId, String skinType, List<int>? allergicListId,
      List<int> benefitListId);
}
