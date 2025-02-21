import 'package:project/features/product/data/model/concern_model.dart';
import 'package:project/features/product/data/model/ingredient_concerns.dart';
import 'package:project/features/product/data/model/skin_problem_solution_model.dart';
import 'package:project/features/product/domain/entities/product_entity.dart';

class UserSpecificInfoModel extends UserSpecificInfoEntity {
  UserSpecificInfoModel(
      {required super.allergicIngredients,
      required super.suitability,
      required super.skinProblemSolutions,
      required super.ingredientConcerns});

  factory UserSpecificInfoModel.fromJson(Map<String, dynamic> json) {
    return UserSpecificInfoModel(
        allergicIngredients: (json['allergicIngredients'] as List)
            .map((e) => ConcernModel.fromJson(e))
            .toList(),
        suitability: SuitabilityEntity(
          isSuitable: json['isSuitable'],
          userSkinType: json['userSkinType'],
        ),
        skinProblemSolutions: (json['skinProblemSolutions'] as List)
            .map((e) => SkinProblemSolutionModel.fromJson(e))
            .toList(),
        ingredientConcerns: (json['ingredientConcerns'] as List)
            .map((e) => IngredientConcerns.fromJson(e))
            .toList());
  }
}
