import 'package:flutter/material.dart';
import 'package:project/features/routine/domain/repository/routine_repository.dart';

class DeleteProduct {
  final RoutineRepository routineRepository;
  DeleteProduct({required this.routineRepository});

  Future<void> deleteProdcutRoiutine(List<int>? productId) async {
    return await routineRepository.deleteProduct(productId);
  }
}
