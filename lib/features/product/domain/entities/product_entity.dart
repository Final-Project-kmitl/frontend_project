class ProductEntity {
  final int id;
  final String name;
  final String brand;
  final double rating;
  final PriceEntity price;
  final String imageUrl;
  final List<SkinTypeEntity> skinTypes;
  final List<ProductTypeEntity> productTypes;
  final List<String> benefits;
  final List<String> concerns;
  final List<IngredientEntity> ingredients;
  final String view;
  final List<String> productBenefits;
  final UserSpecificInfoEntity userSpecificInfo;

  ProductEntity({
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
}

class PriceEntity {
  final String min;
  final String max;

  PriceEntity({
    required this.min,
    required this.max,
  });
}

class SkinTypeEntity {
  final int id;
  final String name;

  SkinTypeEntity({
    required this.id,
    required this.name,
  });
}

class ProductTypeEntity {
  final int id;
  final String name;

  ProductTypeEntity({
    required this.id,
    required this.name,
  });
}

class IngredientEntity {
  final int id;
  final String name;
  final int rating;
  final List<CategoryEntity> categories;
  final List<BenefitEntity> benefits;
  final List<ConcernEntity> concerns;

  IngredientEntity({
    required this.id,
    required this.name,
    required this.rating,
    required this.categories,
    required this.benefits,
    required this.concerns,
  });
}

class CategoryEntity {
  final int id;
  final String name;

  CategoryEntity({
    required this.id,
    required this.name,
  });
}

class BenefitEntity {
  final int id;
  final String name;

  BenefitEntity({
    required this.id,
    required this.name,
  });
}

class ConcernEntity {
  final int id;
  final String name;

  ConcernEntity({
    required this.id,
    required this.name,
  });
}

class UserSpecificInfoEntity {
  final List<AllergicIngredientEntity> allergicIngredients;
  final SuitabilityEntity suitability;
  final List<SkinProblemSolutionEntity> skinProblemSolutions;
  final List<IngredientConcernEntity> ingredientConcerns;

  UserSpecificInfoEntity({
    required this.allergicIngredients,
    required this.suitability,
    required this.skinProblemSolutions,
    required this.ingredientConcerns,
  });
}

class AllergicIngredientEntity {
  final int id;
  final String name;

  AllergicIngredientEntity({
    required this.id,
    required this.name,
  });
}

class SuitabilityEntity {
  final bool isSuitable;
  final SkinTypeEntity userSkinType;

  SuitabilityEntity({
    required this.isSuitable,
    required this.userSkinType,
  });
}

class SkinProblemSolutionEntity {
  final ProblemEntity problem;
  final List<IngredientEntity> solvingIngredients;

  SkinProblemSolutionEntity({
    required this.problem,
    required this.solvingIngredients,
  });
}

class ProblemEntity {
  final int id;
  final String name;

  ProblemEntity({
    required this.id,
    required this.name,
  });
}

class IngredientConcernEntity {
  final IngredientEntity ingredient;
  final List<ConcernEntity> concerns;

  IngredientConcernEntity({
    required this.ingredient,
    required this.concerns,
  });
}