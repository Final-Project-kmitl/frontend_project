import 'dart:async';

import 'package:project/features/home/domain/repository/home_repo.dart';

class GetHomeFavorite {
  final HomeRepo homeRepo;
  GetHomeFavorite({required this.homeRepo});

  Future<List<int>> call() {
    return homeRepo.favorite();
  }
}
