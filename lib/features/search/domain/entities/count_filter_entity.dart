// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:project/features/search/domain/entities/search_entity.dart';

class SubmitReturnEntity {
  final List<ProductEntity> products;
  final CountFilterEntity countFilter;
  SubmitReturnEntity({required this.countFilter, required this.products});

  SubmitReturnEntity copyWith({
    List<ProductEntity>? products,
    CountFilterEntity? countFilter,
  }) {
    return SubmitReturnEntity(
      products: products ?? this.products,
      countFilter: countFilter ?? this.countFilter,
    );
  }
}

class SkinTypEntity extends Equatable {
  final int id;
  final String name;
  final int count;
  SkinTypEntity({
    required this.id,
    required this.name,
    required this.count,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, count];
}

class ProductTypeEntity extends Equatable {
  final int id;
  final String name;
  final int count;
  ProductTypeEntity({
    required this.id,
    required this.name,
    required this.count,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, count];
}

class BrandEntity extends Equatable {
  final String name;
  final int count;
  BrandEntity({
    required this.name,
    required this.count,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, count];
}

class CountFilterEntity {
  List<SkinTypEntity> skinTypes;
  List<ProductTypeEntity> productTypes;
  List<BrandEntity> brands;
  CountFilterEntity({
    required this.skinTypes,
    required this.productTypes,
    required this.brands,
  });
}
