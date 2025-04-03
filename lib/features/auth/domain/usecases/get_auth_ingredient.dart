import 'package:project/features/auth/domain/entities/ingredient_entity.dart';
import 'package:project/features/auth/domain/repository/ingredient_repository.dart';

class GetAuthIngredient {
  final IngredientRepository ingredientRepository;
  GetAuthIngredient({required this.ingredientRepository});

  Future<List<IngredientEntity>> call(String ingredient) {
    return ingredientRepository.fetchingredient(ingredient);
  }
}
