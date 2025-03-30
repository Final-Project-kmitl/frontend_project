import 'package:project/features/profile/domain/entities/user_entity.dart';

class SkinProblemModel extends SkinProblemEntity {
  SkinProblemModel({required super.id, required super.problem});

  factory SkinProblemModel.fromJson(Map<String, dynamic> json) {
    return SkinProblemModel(
      id: json['id'],
      problem: json['problem'],
    );
  }
}
