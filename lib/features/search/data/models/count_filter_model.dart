import 'package:project/features/search/data/models/product_model.dart';
import 'package:project/features/search/domain/entities/count_filter_entity.dart';

class SubmitReturnModel extends SubmitReturnEntity {
  SubmitReturnModel({required super.countFilter, required super.products});

  factory SubmitReturnModel.fromJson(Map<String, dynamic> json) {
    return SubmitReturnModel(
        countFilter: CountFilterModel.fromJson(json['count_filter']),
        products: (json['product'] as List)
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

class CountFilterModel extends CountFilterEntity {
  CountFilterModel(
      {required super.skinTypes,
      required super.productTypes,
      required super.brands});

  factory CountFilterModel.fromJson(Map<String, dynamic> json) {
    return CountFilterModel(
      skinTypes: (json['skinTypes'] as List<dynamic>)
          .map((e) => SkinTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productTypes: (json['productTypes'] as List<dynamic>)
          .map((e) => ProductTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands: (json['brands'] as List<dynamic>)
          .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ProductTypeModel extends ProductTypeEntity {
  ProductTypeModel({
    required super.id,
    required super.name,
    required super.count,
  });

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(
      id: json['id'],
      name: json['name'] ?? "",
      count: json['count'] ?? "",
    );
  }
}

class SkinTypeModel extends SkinTypEntity {
  SkinTypeModel({
    required super.id,
    required super.name,
    required super.count,
  });

  factory SkinTypeModel.fromJson(Map<String, dynamic> json) {
    return SkinTypeModel(
      id: json['id'],
      name: json['name'] ?? "",
      count: json['count'] ?? "",
    );
  }
}

class BrandModel extends BrandEntity {
  BrandModel({
    required super.name,
    required super.count,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      name: json['name'] ?? "",
      count: json['count'] ?? "",
    );
  }
}
