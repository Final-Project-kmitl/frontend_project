import 'package:flutter/material.dart';
import 'package:project/features/routine/data/datasource/routine_datasource.dart';
import 'package:project/features/routine/domain/entities/no_match_entity.dart';
import 'package:project/features/routine/domain/entities/product_entity.dart';
import 'package:project/features/routine/domain/repository/routine_repository.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final RoutineRemoteDatasource routineRemoteDatasource;

  RoutineRepositoryImpl({required this.routineRemoteDatasource});
  @override
  Future<List<NoMatchEntity>> getNoMatchRoutine() async {
    return await routineRemoteDatasource.fetchNoMatchRoutine();
  }

  @override
  Future<List<ProductEntity>> getProductRoutine() async {
    return await routineRemoteDatasource.fetchProductRoutine();
  }

  @override
  Future<void> deleteProduct(List<int>? productId) async {
    return await routineRemoteDatasource.deleteProduct(productId);
  }
}
