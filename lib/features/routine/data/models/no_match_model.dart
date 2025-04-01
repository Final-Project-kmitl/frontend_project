import 'package:project/features/routine/domain/entities/no_match_entity.dart';

class NoMatchModel extends NoMatchEntity {
  NoMatchModel({
    required super.ingredient1,
    required super.ingredient2,
    required super.product1,
    required super.product2,
    required super.brand1,
    required super.brand2,
  });

  // json -> obj
  factory NoMatchModel.fromJson(Map<String, dynamic> json) {
    return NoMatchModel(
      ingredient1: json['ingredient_1'],
      ingredient2: json['ingredient_2'],
      product1: json['product_1'],
      product2: json['product_2'],
      brand1: json['brand_1'],
      brand2: json['brand_2'],
    );
  }

  // obj -> json
  Map<String, dynamic> toJson() {
    return {
      "ingredient1": ingredient1,
      "ingredient2": ingredient2,
      "product1": product1,
      "product2": product2,
    };
  }
}
