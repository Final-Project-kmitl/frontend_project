import 'package:project/features/product/data/model/concern_model.dart';
import 'package:project/features/product/domain/entities/product_entity.dart';

class SkinProblemSolutionModel extends SkinProblemSolutionEntity {
  SkinProblemSolutionModel(
      {required super.problem, required super.solvingIngredients});

  factory SkinProblemSolutionModel.fromJson(Map<String, dynamic> json) {
    return SkinProblemSolutionModel(
        problem: json['problem'],
        solvingIngredients: (json['solvingIngredients'] as List)
            .map((e) => ConcernModel.fromJson(e))
            .toList());
  }
}
