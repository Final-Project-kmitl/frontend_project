import 'package:project/features/profile/domain/entities/user_entity.dart';

class SkinTypeModel extends SkinTypeEntity {
  SkinTypeModel({required super.id, required super.name});

  factory SkinTypeModel.fromJson(Map<String, dynamic> json) {
    return SkinTypeModel(id: json['id'], name: json['name']);
  }
}
