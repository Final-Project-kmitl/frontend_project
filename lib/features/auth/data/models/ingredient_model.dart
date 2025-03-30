import 'package:project/features/auth/domain/entities/ingredient_entity.dart';

// map ข้อมูลที่ได้จาก backend ให้ตรงกับ entity ที่ได้ออกแบบไว้
class IngredientModel extends IngredientEntity {
  IngredientModel({required super.id, required super.name});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(id: json['id'], name: json['name']);
  }
}
