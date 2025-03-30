import 'package:project/features/product/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.rating,
    required super.price,
    required super.imageUrl,
    required super.skinTypes,
    required super.productTypes,
    required super.benefits,
    required super.concerns,
    required super.ingredients,
    required super.view,
    required super.productBenefits,
    required super.userSpecificInfo,
    required super.isFav,
    required super.isRoutine,
    required super.routineCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      rating: double.parse(json['rating']),
      price: PriceModel.fromJson(json['price']),
      imageUrl: json['image_url'] ?? "",
      skinTypes: (json['skinTypes'] as List)
          .map((e) => SkinTypeModel.fromJson(e))
          .toList(),
      productTypes: (json['productTypes'] as List)
          .map((e) => ProductTypeModel.fromJson(e))
          .toList(),
      benefits: List<String>.from(json['benefits']),
      concerns: List<String>.from(json['concerns']),
      ingredients: (json['ingredients'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList(),
      view: json['view'],
      productBenefits: (json['product_benefits'] as List)
          .map((productBenefit) => ProductBenefitModel.fromJson(productBenefit))
          .toList(),
      userSpecificInfo:
          UserSpecificInfoModel.fromJson(json['userSpecificInfo']),
      isFav: json['isFav'] ?? false,
      isRoutine: json['isRoutine'] ?? true,
      routineCount: json['routineCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'rating': rating,
      'price': (price as PriceModel).toJson(),
      'image_url': imageUrl,
      'skinTypes': skinTypes.map((e) => (e as SkinTypeModel).toJson()).toList(),
      'productTypes':
          productTypes.map((e) => (e as ProductTypeModel).toJson()).toList(),
      'benefits': benefits,
      'concerns': concerns,
      'ingredients':
          ingredients.map((e) => (e as IngredientModel).toJson()).toList(),
      'view': view,
      'product_benefits': productBenefits,
      'userSpecificInfo': (userSpecificInfo as UserSpecificInfoModel).toJson(),
      "isFav": isFav,
      "isRoutine": isRoutine,
    };
  }

  ProductModel copyWith({
    bool? isFav,
    bool? isRoutine,
    int? routineCount,
  }) {
    return ProductModel(
      id: id,
      name: name,
      brand: brand,
      rating: rating,
      price: price,
      imageUrl: imageUrl,
      skinTypes: skinTypes,
      productTypes: productTypes,
      benefits: benefits,
      concerns: concerns,
      ingredients: ingredients,
      view: view,
      productBenefits: productBenefits,
      userSpecificInfo: userSpecificInfo,
      isFav: isFav ?? this.isFav,
      isRoutine: isRoutine ?? this.isRoutine,
      routineCount: routineCount ?? this.routineCount,
    );
  }
}

class FavoriteProductModel extends FavoriteProductEntity {
  FavoriteProductModel(
      {required super.brand,
      required super.id,
      required super.image_url,
      required super.max_price,
      required super.min_price,
      required super.name,
      required super.view});

  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProductModel(
        brand: json['brand'],
        id: json['id'],
        image_url: json['image_url'],
        max_price: json['max_price'],
        min_price: json['min_price'],
        name: json['name'],
        view: json['view']);
  }
  FavoriteProductEntity toEntity() {
    return FavoriteProductEntity(
      id: id,
      brand: brand,
      name: name,
      min_price: min_price,
      max_price: max_price,
      image_url: image_url,
      view: view,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'name': name,
      'image_url': image_url,
      'max_price': max_price,
      'min_price': min_price,
      'view': view,
    };
  }
}

class PriceModel extends PriceEntity {
  PriceModel({
    required super.min,
    required super.max,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      min: json['min'],
      max: json['max'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
    };
  }
}

class SkinTypeModel extends SkinTypeEntity {
  SkinTypeModel({
    required super.id,
    required super.name,
  });

  factory SkinTypeModel.fromJson(Map<String, dynamic> json) {
    return SkinTypeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ProductTypeModel extends ProductTypeEntity {
  ProductTypeModel({
    required super.id,
    required super.name,
  });

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class IngredientModel extends IngredientEntity {
  IngredientModel({
    required super.id,
    required super.name,
    required super.rating,
    required super.categories,
    required super.benefits,
    required super.concerns,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    try {
      return IngredientModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        rating: json['rating'] ?? "not_rated",
        categories: json['categories'] != null
            ? (json['categories'] as List)
                .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        benefits: json['benefits'] != null
            ? (json['benefits'] as List)
                .map((e) => BenefitModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        concerns: json['concerns'] != null
            ? (json['concerns'] as List)
                .map((e) => ConcernModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
      );
    } catch (e) {
      print('Error parsing IngredientModel: $e');
      return IngredientModel(
        id: 0,
        name: '',
        rating: 'not rated',
        categories: [],
        benefits: [],
        concerns: [],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'categories':
          categories.map((e) => (e as CategoryModel).toJson()).toList(),
      'benefits': benefits.map((e) => (e as BenefitModel).toJson()).toList(),
      'concerns': concerns.map((e) => (e as ConcernModel).toJson()).toList(),
    };
  }
}

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class BenefitModel extends BenefitEntity {
  BenefitModel({
    required super.id,
    required super.name,
  });

  factory BenefitModel.fromJson(Map<String, dynamic> json) {
    return BenefitModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ProductBenefitModel extends ProductBenefitEntity {
  ProductBenefitModel({required super.benefit, required super.ingredients});

  factory ProductBenefitModel.fromJson(Map<String, dynamic> json) {
    return ProductBenefitModel(
        benefit: json['benefit'],
        ingredients: List<String>.from(json['ingredients']));
  }
}

class ConcernModel extends ConcernEntity {
  ConcernModel({
    required super.id,
    required super.name,
  });

  factory ConcernModel.fromJson(Map<String, dynamic> json) {
    try {
      return ConcernModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
    } catch (e) {
      print('Error parsing ConcernModel: $e');
      return ConcernModel(id: 0, name: '');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class UserSpecificInfoModel extends UserSpecificInfoEntity {
  UserSpecificInfoModel({
    required super.allergicIngredients,
    required super.suitability,
    required super.skinProblemSolutions,
    required super.ingredientConcerns,
  });

  factory UserSpecificInfoModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserSpecificInfoModel(
      allergicIngredients: (json['allergicIngredients'] as List)
          .map((e) => AllergicIngredientModel.fromJson(e))
          .toList(),
      suitability: SuitabilityModel.fromJson(json['suitability']),
      skinProblemSolutions: (json['skinProblemSolutions'] as List)
          .map((e) => SkinProblemSolutionModel.fromJson(e))
          .toList(),
      ingredientConcerns: (json['ingredientConcerns'] as List)
          .map((e) => IngredientConcernModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'allergicIngredients': allergicIngredients
          .map((e) => (e as AllergicIngredientModel).toJson())
          .toList(),
      'suitability': (suitability as SuitabilityModel).toJson(),
      'skinProblemSolutions': skinProblemSolutions
          .map((e) => (e as SkinProblemSolutionModel).toJson())
          .toList(),
      'ingredientConcerns': ingredientConcerns
          .map((e) => (e as IngredientConcernModel).toJson())
          .toList(),
    };
  }
}

class AllergicIngredientModel extends AllergicIngredientEntity {
  AllergicIngredientModel({
    required super.id,
    required super.name,
  });

  factory AllergicIngredientModel.fromJson(Map<String, dynamic> json) {
    return AllergicIngredientModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class SuitabilityModel extends SuitabilityEntity {
  SuitabilityModel({
    required super.isSuitable,
    required super.userSkinType,
  });

  factory SuitabilityModel.fromJson(Map<String, dynamic> json) {
    return SuitabilityModel(
      isSuitable: json['isSuitable'],
      userSkinType: SkinTypeModel.fromJson(json['userSkinType']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSuitable': isSuitable,
      'userSkinType': (userSkinType as SkinTypeModel).toJson(),
    };
  }
}

class SkinProblemSolutionModel extends SkinProblemSolutionEntity {
  SkinProblemSolutionModel({
    required super.problem,
    required super.solvingIngredients,
  });

  factory SkinProblemSolutionModel.fromJson(Map<String, dynamic> json) {
    return SkinProblemSolutionModel(
      problem: ProblemModel.fromJson(json['problem']),
      solvingIngredients: (json['solvingIngredients'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'problem': (problem as ProblemModel).toJson(),
      'solvingIngredients': solvingIngredients
          .map((e) => (e as IngredientModel).toJson())
          .toList(),
    };
  }
}

class ProblemModel extends ProblemEntity {
  ProblemModel({
    required super.id,
    required super.name,
  });

  factory ProblemModel.fromJson(Map<String, dynamic> json) {
    return ProblemModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class IngredientConcernModel extends IngredientConcernEntity {
  IngredientConcernModel({
    required super.concern,
    required super.ingredients,
  });

  factory IngredientConcernModel.fromJson(Map<String, dynamic> json) {
    return IngredientConcernModel(
      concern:
          ConcernModel.fromJson(json['concern']), // concern เป็น object เดียว
      ingredients: (json['ingredients'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'concern': (concern as ConcernModel).toJson(),
      'ingredients': ingredients.map((e) => (e as IngredientModel)).toList(),
    };
  }
}
