import 'package:project/features/product/domain/entities/product_entity.dart';

class PriceModel extends PriceEntity {
  PriceModel({required super.min, required super.max});

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(min: json['min'], max: json['max']);
  }
}
