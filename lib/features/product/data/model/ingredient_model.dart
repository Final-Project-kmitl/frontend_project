import 'package:project/features/product/domain/entities/product_entity.dart';

class IngredientModel extends IngredientEntity {
  IngredientModel(
      {required super.id,
      required super.name,
      required super.rating,
      required super.categories,
      required super.concerns,
      required super.benefits});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
        id: json['id'],
        name: json['name'],
        rating: json['rating'],
        categories: json['categories'],
        concerns: json['concerns'],
        benefits: json['benefits']);
  }
}
