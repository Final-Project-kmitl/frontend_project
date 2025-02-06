import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String brand;
  final String product;
  final String img;
  ProductEntity(
      {required this.id,
      required this.brand,
      required this.product,
      required this.img});

  @override
  // TODO: implement props
  List<Object?> get props => [id, brand, product, img];
}
