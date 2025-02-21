import 'package:project/features/product/data/model/concern_model.dart';
import 'package:project/features/product/domain/entities/product_entity.dart';

class IngredientConcerns extends IngredientConcernEntity {
  IngredientConcerns({required super.ingredient, required super.concerns});

  factory IngredientConcerns.fromJson(Map<String, dynamic> json) {
    return IngredientConcerns(
        ingredient: json['ingredient'],
        concerns: (json['concerns'] as List)
            .map((e) => ConcernModel.fromJson(e))
            .toList());
  }
}
