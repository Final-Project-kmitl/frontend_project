import 'package:project/features/product/data/model/concern_model.dart';
import 'package:project/features/product/data/model/ingredient_model.dart';
import 'package:project/features/product/data/model/price_model.dart';
import 'package:project/features/product/data/model/product_type_model.dart';
import 'package:project/features/product/data/model/skin_type_model.dart';
import 'package:project/features/product/data/model/user_specific_info_model.dart';
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
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      rating: json['rating'],
      price: PriceModel.fromJson(json['price']),
      imageUrl: json['image_url'],
      skinTypes: (json['skinTypes'] as List)
          .map((e) => SkinTypeModel.fromJson(e))
          .toList(),
      productTypes: (json['productTypes'] as List)
          .map((e) => ProductTypeModel.fromJson(e))
          .toList(),
      benefits: List<String>.from(json['benefits']),
      concerns: (json['concerns'] as List)
          .map((e) => ConcernModel.fromJson(e))
          .toList(),
      ingredients: (json['ingredients'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList(),
      view: int.parse(json['view']),
      productBenefits: List<String>.from(json['product_benefits']),
      userSpecificInfo:
          UserSpecificInfoModel.fromJson(json['userSpecificInfo']),
    );
  }
}
