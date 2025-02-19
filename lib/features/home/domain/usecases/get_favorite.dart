import 'dart:async';

import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/domain/repository/home_repo.dart';

class GetHomeFavorite {
  final HomeRepo homeRepo;
  GetHomeFavorite({required this.homeRepo});

  Future<List<FavoriteProductEntity>> call() {
    return homeRepo.favorite();
  }
}
