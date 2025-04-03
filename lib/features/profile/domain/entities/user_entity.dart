import 'package:equatable/equatable.dart';

class SkinTypeEntity extends Equatable {
  final int id;
  final String name;

  SkinTypeEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class AllergyEntity extends Equatable {
  final int id;
  final String name;
  final int rating;

  AllergyEntity({
    required this.id,
    required this.name,
    required this.rating,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, rating];
}

class SkinProblemEntity extends Equatable {
  final int id;
  final String problem;

  SkinProblemEntity({
    required this.id,
    required this.problem,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, problem];
}

class UserEntity extends Equatable {
  final int id;
  final SkinTypeEntity? skinType;
  final List<AllergyEntity>? allergies;
  final List<SkinProblemEntity>? skinProblems;

  UserEntity(
      {this.allergies, required this.id, this.skinProblems, this.skinType});

  @override
  List<Object?> get props => [
        allergies,
        id,
        skinProblems,
        skinType,
      ];
}
