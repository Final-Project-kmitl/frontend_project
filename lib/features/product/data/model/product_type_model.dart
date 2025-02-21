import 'package:project/features/product/domain/entities/product_entity.dart';

class ProductTypeModel extends ProductTypeEntity {
  ProductTypeModel({required super.id, required super.name});

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(id: json['id'], name: json['name']);
  }
}
