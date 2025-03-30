// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:project/features/auth/data/datasource/search_ingredient.dart';
import 'package:project/features/auth/domain/entities/ingredient_entity.dart';
import 'package:project/features/auth/domain/repository/ingredient_repository.dart';

class IngredientRepoImpl implements IngredientRepository {
  final AuthApiService authApiService;
  IngredientRepoImpl({
    required this.authApiService,
  });

  @override
  Future<List<IngredientEntity>> fetchingredient(String ingredient) {
    return authApiService.fetchIngredient(ingredient);
  }

  @override
  Future<void> userRegister(int userId, String skinType, List<int>? allergicListId,
      List<int> benefitListId) {
    return authApiService.fetchUser(
        userId, skinType, allergicListId, benefitListId);
  }
}
