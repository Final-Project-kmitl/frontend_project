import 'package:dartz/dartz.dart';
import 'package:project/features/routine/data/models/no_match_model.dart';

final List<Map<String, dynamic>> mockNoMatchJson = [
  {
    "product1": "Senka Perfect Whip",
    "ingredient1": "Retinol",
    "product2": "OOTD Dark Spot Vitamin C Serum",
    "ingredient2": "AHA"
  },
  {
    "product1": "Senka Perfect Whip",
    "ingredient1": "Retinol",
    "product2": "OOTD Dark Spot Vitamin C Serum",
    "ingredient2": "Vitamin C"
  }
];

final List<NoMatchModel> mockNoMatchData =
    mockNoMatchJson.map((e) => NoMatchModel.fromJson(e)).toList();
