import 'package:project/features/product/domain/entities/product_entity.dart';

class ConcernModel extends ConcernEntity {
  ConcernModel({required super.id, required super.name});

  factory ConcernModel.fromJson(Map<String, dynamic> json) {
    return ConcernModel(id: json['id'], name: json['name']);
  }
}
