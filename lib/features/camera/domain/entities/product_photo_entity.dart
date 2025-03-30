class ProductPhotoEntity {
  final List<DetectedIngredient>? detectedIngredients;
  final List<MatchingProduct>? matchingProducts;
  final List<OriginalFileInfo>? originalFileInfo;
  final ProductDetails? productDetails;

  ProductPhotoEntity({
    this.detectedIngredients,
    this.matchingProducts,
    this.originalFileInfo,
    this.productDetails,
  });

  factory ProductPhotoEntity.fromJson(Map<String, dynamic> json) {
    return ProductPhotoEntity(
      detectedIngredients: json['detectedIngredients'] != null
          ? List<DetectedIngredient>.from(json['detectedIngredients']
              .map((x) => DetectedIngredient.fromJson(x)))
          : null,
      matchingProducts: json['matchingProducts'] != null
          ? List<MatchingProduct>.from(
              json['matchingProducts'].map((x) => MatchingProduct.fromJson(x)))
          : null,
      originalFileInfo: json['originalFileInfo'] != null
          ? List<OriginalFileInfo>.from(
              json['originalFileInfo'].map((x) => OriginalFileInfo.fromJson(x)))
          : null,
      productDetails: json['productDetails'] != null
          ? ProductDetails.fromJson(json['productDetails'])
          : null,
    );
  }
}

class DetectedIngredient {
  final int? id;
  final String? name;
  final int? rating;
  final double? confidence;

  DetectedIngredient({
    this.id,
    this.name,
    this.rating,
    this.confidence,
  });

  factory DetectedIngredient.fromJson(Map<String, dynamic> json) {
    return DetectedIngredient(
      id: json['id'],
      name: json['name'],
      rating: json['rating'],
      confidence: json['confidence']?.toDouble(),
    );
  }
}

class MatchingProduct {
  final int? id;
  final String? name;
  final String? image;
  final String? brand;
  final double? confidence;
  final List<DetectedIngredient>? matchingIngredients;
  final List<DetectedIngredient>? missingIngredients;
  final int? totalIngredientsCount;
  final double? matchPercentage;
  final int? rating;

  MatchingProduct(
      {this.id,
      this.name,
      this.image,
      this.brand,
      this.confidence,
      this.matchingIngredients,
      this.missingIngredients,
      this.totalIngredientsCount,
      this.matchPercentage,
      this.rating});

  factory MatchingProduct.fromJson(Map<String, dynamic> json) {
    return MatchingProduct(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        brand: json['brand'],
        confidence: json['confidence']?.toDouble(),
        matchingIngredients: json['matchingIngredients'] != null
            ? List<DetectedIngredient>.from(json['matchingIngredients']
                .map((x) => DetectedIngredient.fromJson(x)))
            : null,
        missingIngredients: json['missingIngredients'] != null
            ? List<DetectedIngredient>.from(json['missingIngredients']
                .map((x) => DetectedIngredient.fromJson(x)))
            : null,
        totalIngredientsCount: json['totalIngredientsCount'],
        matchPercentage: json['matchPercentage']?.toDouble(),
        rating: json['rating']);
  }
}

class OriginalFileInfo {
  final String? originalname;
  final String? mimetype;
  final int? size;

  OriginalFileInfo({
    this.originalname,
    this.mimetype,
    this.size,
  });

  factory OriginalFileInfo.fromJson(Map<String, dynamic> json) {
    return OriginalFileInfo(
      originalname: json['originalname'],
      mimetype: json['mimetype'],
      size: json['size'],
    );
  }
}

class ProductDetails {
  final List<IngredientDetail>? ingredients;
  final List<String>? benefits;
  final List<String>? concerns;
  final List<ProductBenefit>? productBenefits;

  ProductDetails({
    this.ingredients,
    this.benefits,
    this.concerns,
    this.productBenefits,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      ingredients: json['ingredients'] != null
          ? List<IngredientDetail>.from(
              json['ingredients'].map((x) => IngredientDetail.fromJson(x)))
          : null,
      benefits: json['benefits'] != null
          ? List<String>.from(json['benefits'].map((x) => x))
          : null,
      concerns: json['concerns'] != null
          ? List<String>.from(json['concerns'].map((x) => x))
          : null,
      productBenefits: json['product_benefits'] != null
          ? List<ProductBenefit>.from(
              json['product_benefits'].map((x) => ProductBenefit.fromJson(x)))
          : null,
    );
  }
}

class IngredientDetail {
  final int? id;
  final String? name;
  final String? rating;
  final List<Category>? categories;
  final List<Benefit>? benefits;
  final List<Concern>? concerns;

  IngredientDetail({
    this.id,
    this.name,
    this.rating,
    this.categories,
    this.benefits,
    this.concerns,
  });

  factory IngredientDetail.fromJson(Map<String, dynamic> json) {
    return IngredientDetail(
      id: json['id'],
      name: json['name'],
      rating: json['rating'],
      categories: json['categories'] != null
          ? List<Category>.from(
              json['categories'].map((x) => Category.fromJson(x)))
          : null,
      benefits: json['benefits'] != null
          ? List<Benefit>.from(json['benefits'].map((x) => Benefit.fromJson(x)))
          : null,
      concerns: json['concerns'] != null
          ? List<Concern>.from(json['concerns'].map((x) => Concern.fromJson(x)))
          : null,
    );
  }
}

class Category {
  final int? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Benefit {
  final int? id;
  final String? name;

  Benefit({
    this.id,
    this.name,
  });

  factory Benefit.fromJson(Map<String, dynamic> json) {
    return Benefit(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Concern {
  final int? id;
  final String? name;

  Concern({
    this.id,
    this.name,
  });

  factory Concern.fromJson(Map<String, dynamic> json) {
    return Concern(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProductBenefit {
  final String? benefit;
  final List<String>? ingredients;

  ProductBenefit({
    this.benefit,
    this.ingredients,
  });

  factory ProductBenefit.fromJson(Map<String, dynamic> json) {
    return ProductBenefit(
      benefit: json['benefit'],
      ingredients: json['ingredients'] != null
          ? List<String>.from(json['ingredients'].map((x) => x))
          : null,
    );
  }
}
