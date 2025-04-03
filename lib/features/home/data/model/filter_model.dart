import 'package:project/features/home/data/model/product_model.dart';
import 'package:project/features/home/domain/entities/filter_entity.dart';

class FilterModel extends FilterEntity {
  FilterModel(
      {required super.skinTypes,
      required super.productTypes,
      required super.brands});

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
        skinTypes: (json['skinTypes'] as List)
            .map((e) => SkinTypeModel.fromjson(e))
            .toList(),
        productTypes: (json['productTypes'] as List)
            .map((e) => SkinTypeModel.fromjson(e))
            .toList(),
        brands: (json['brands'] as List)
            .map((e) => BrandModel.fromJson(e))
            .toList());
  }
}

class MergeReturnFilterByBenefitModel extends MergeReturnFilterByBenefitEntity {
  MergeReturnFilterByBenefitModel(
      {required super.products, required super.filterCount});

  factory MergeReturnFilterByBenefitModel.fromJson(
      {required Map<String, dynamic> productJson,
      required Map<String, dynamic> filterJson}) {
    return MergeReturnFilterByBenefitModel(
        products: (productJson['data'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList(),
        filterCount: FilterModel.fromJson(filterJson));
  }
}

class BrandModel extends BrandsEntity {
  BrandModel({required super.name, required super.count});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(name: json['name'], count: json['count']);
  }
}

class SkinTypeModel extends SkinTypeEntity {
  SkinTypeModel({required super.id, required super.name, required super.count});

  factory SkinTypeModel.fromjson(Map<String, dynamic> json) {
    return SkinTypeModel(
        id: json['id'], name: json['name'] ?? "", count: json['count']);
  }
}
