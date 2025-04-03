import 'package:project/features/profile/domain/entities/user_entity.dart';

class AllergyModel extends AllergyEntity {
  AllergyModel({required super.id, required super.name, required super.rating});

  factory AllergyModel.fromJson(Map<String, dynamic> json) {
    return AllergyModel(
      id: json['id'],
      name: json['name'],
      rating: json['rating'],
    );
  }
}
