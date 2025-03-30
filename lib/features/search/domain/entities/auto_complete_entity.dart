// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AutoCompleteEntity extends Equatable {
  final int id;
  final String name;
  final String brand;
  AutoCompleteEntity({
    required this.id,
    required this.name,
    required this.brand,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, brand];
}
