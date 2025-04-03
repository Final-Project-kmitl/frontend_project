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
  final int view;
  final List<ProductBenefitEntity> productBenefits;
  final UserSpecificInfoEntity userSpecificInfo;
  final bool isFav;
  final bool isRoutine;
  final int routineCount;
  final SkincareDetailsEntity? skincareDetails;
  final String? barcodeId;
  final List<ProductRelateEntity> productRelate;

  ProductEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.skinTypes,
    required this.productTypes,
    required this.isRoutine,
    required this.benefits,
    required this.concerns,
    required this.ingredients,
    required this.view,
    required this.productBenefits,
    required this.userSpecificInfo,
    required this.isFav,
    required this.routineCount,
    this.skincareDetails,
    this.barcodeId,
    required this.productRelate,
  });

  ProductEntity copyWith({bool? isFav}) {
    return ProductEntity(
      id: id,
      name: name,
      brand: brand,
      rating: rating,
      price: price,
      imageUrl: imageUrl,
      isRoutine: isRoutine,
      routineCount: routineCount,
      skinTypes: skinTypes,
      productTypes: productTypes,
      benefits: benefits,
      concerns: concerns,
      ingredients: ingredients,
      view: view,
      productBenefits: productBenefits,
      userSpecificInfo: userSpecificInfo,
      isFav: isFav ?? this.isFav,
      skincareDetails: skincareDetails,
      barcodeId: barcodeId,
      productRelate: productRelate,
    );
  }
}

class FavoriteProductEntity {
  final int id;
  final String brand;
  final String name;
  final String min_price;
  final String max_price;
  final String image_url;
  final String view;

  FavoriteProductEntity({
    required this.brand,
    required this.id,
    required this.image_url,
    required this.max_price,
    required this.min_price,
    required this.name,
    required this.view,
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

class ProductRelateEntity {
  final int id;
  final String brand;
  final String name;
  final String image_url;
  ProductRelateEntity({
    required this.id,
    required this.brand,
    required this.name,
    required this.image_url,
  });
}

class IngredientEntity {
  final int id;
  final String name;
  final String rating;
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
  final ConcernEntity concern;
  final List<IngredientEntity> ingredients;

  IngredientConcernEntity({
    required this.concern,
    required this.ingredients,
  });
}

class ProductBenefitEntity {
  final String benefit;
  final List<String> ingredients;

  ProductBenefitEntity({
    required this.benefit,
    required this.ingredients,
  });
}

class SkincareDetailsEntity {
  final int allergyScore;
  final int skinTypeScore;
  final int concernScore;
  final int worseningScore;
  final int irritationScore;

  SkincareDetailsEntity({
    required this.allergyScore,
    required this.skinTypeScore,
    required this.concernScore,
    required this.worseningScore,
    required this.irritationScore,
  });
}
