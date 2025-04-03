import 'package:project/features/search/domain/entities/auto_complete_entity.dart';

class AutoCompleteModel extends AutoCompleteEntity {
  AutoCompleteModel(
      {required super.id, required super.name, required super.brand});

  factory AutoCompleteModel.fromJson(Map<String, dynamic> json) {
    return AutoCompleteModel(
        id: json['id'], name: json['name'], brand: json['brand']);
  }
}
