import 'package:project/features/profile/data/model/allergy_model.dart';
import 'package:project/features/profile/data/model/skin_problem_model.dart';
import 'package:project/features/profile/data/model/skin_type.dart';
import 'package:project/features/profile/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.allergies,
      required super.id,
      required super.skinProblems,
      super.skinType});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      skinType: json['skinType'] != null
          ? SkinTypeModel.fromJson(json['skinType'])
          : null,
      allergies: (json['allergies'] as List?)
              ?.map(
                  (item) => AllergyModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      skinProblems: (json['skinProblems'] as List?)
              ?.map((item) =>
                  SkinProblemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
