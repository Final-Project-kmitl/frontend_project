import 'package:equatable/equatable.dart';

class NoMatchEntity extends Equatable {
  final String product1;
  final String ingredient1;
  final String product2;
  final String ingredient2;
  final String brand1;
  final String brand2;

  NoMatchEntity(
      {required this.product1,
      required this.ingredient1,
      required this.ingredient2,
      required this.product2,
      required this.brand1,
      required this.brand2});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [product1, ingredient1, product2, ingredient2, brand1, brand2];
}
