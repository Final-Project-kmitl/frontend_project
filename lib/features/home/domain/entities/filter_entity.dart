// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:project/features/home/domain/entities/product_entity.dart';

class FilterEntity {
  final List<SkinTypeEntity> skinTypes;
  final List<SkinTypeEntity> productTypes;
  final List<BrandsEntity> brands;
  FilterEntity({
    required this.skinTypes,
    required this.productTypes,
    required this.brands,
  });
}

class MergeReturnFilterByBenefitEntity {
  final List<ProductEntity> products;
  final FilterEntity filterCount;
  MergeReturnFilterByBenefitEntity({
    required this.products,
    required this.filterCount,
  });
}

class SkinTypeEntity {
  final int id;
  final String name;
  final int count;
  SkinTypeEntity({
    required this.id,
    required this.name,
    required this.count,
  });
}

class BrandsEntity {
  final String name;
  final int count;
  BrandsEntity({
    required this.name,
    required this.count,
  });
}
