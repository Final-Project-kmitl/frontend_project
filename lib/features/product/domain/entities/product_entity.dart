import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String brand;
  final int rating;
  final PriceEntity price;
  final String imageUrl;
  final List<SkinTypeEntity> skinTypes;
  final List<ProductTypeEntity> productTypes;
  final List<String> benefits;
  final List<ConcernEntity> concerns;
  final List<IngredientEntity> ingredients;
  final int view;
  final List<String> productBenefits;
  final UserSpecificInfoEntity userSpecificInfo;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.skinTypes,
    required this.productTypes,
    required this.benefits,
    required this.concerns,
    required this.ingredients,
    required this.view,
    required this.productBenefits,
    required this.userSpecificInfo,
  });

  @override
  List<Object?> get props => [id, name, brand, rating, price, imageUrl, view];
}

class PriceEntity extends Equatable {
  final String min;
  final String max;

  const PriceEntity({required this.min, required this.max});

  @override
  List<Object?> get props => [min, max];
}

class SkinTypeEntity extends Equatable {
  final int id;
  final String name;

  const SkinTypeEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class ProductTypeEntity extends Equatable {
  final int id;
  final String name;

  const ProductTypeEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class ConcernEntity extends Equatable {
  final int id;
  final String name;

  const ConcernEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class IngredientEntity extends Equatable {
  final int id;
  final String name;
  final int rating;
  final List<CategoryEntity> categories;
  final List<ConcernEntity> concerns;
  final List<BenefitEntity> benefits;

  const IngredientEntity({
    required this.id,
    required this.name,
    required this.rating,
    required this.categories,
    required this.concerns,
    required this.benefits,
  });

  @override
  List<Object?> get props => [id, name, rating];
}

class CategoryEntity extends Equatable {
  final int id;
  final String name;

  const CategoryEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class BenefitEntity extends Equatable {
  final int id;
  final String name;

  const BenefitEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class UserSpecificInfoEntity extends Equatable {
  final List<ConcernEntity> allergicIngredients;
  final SuitabilityEntity suitability;
  final List<SkinProblemSolutionEntity> skinProblemSolutions;
  final List<IngredientConcernEntity> ingredientConcerns;

  const UserSpecificInfoEntity({
    required this.allergicIngredients,
    required this.suitability,
    required this.skinProblemSolutions,
    required this.ingredientConcerns,
  });

  @override
  List<Object?> get props => [
        allergicIngredients,
        suitability,
        skinProblemSolutions,
        ingredientConcerns
      ];
}

class SuitabilityEntity extends Equatable {
  final bool isSuitable;
  final SkinTypeEntity userSkinType;

  const SuitabilityEntity(
      {required this.isSuitable, required this.userSkinType});

  @override
  List<Object?> get props => [isSuitable, userSkinType];
}

class SkinProblemSolutionEntity extends Equatable {
  final ConcernEntity problem;
  final List<ConcernEntity> solvingIngredients;

  const SkinProblemSolutionEntity(
      {required this.problem, required this.solvingIngredients});

  @override
  List<Object?> get props => [problem, solvingIngredients];
}

class IngredientConcernEntity extends Equatable {
  final ConcernEntity ingredient;
  final List<ConcernEntity> concerns;

  const IngredientConcernEntity(
      {required this.ingredient, required this.concerns});

  @override
  List<Object?> get props => [ingredient, concerns];
}
