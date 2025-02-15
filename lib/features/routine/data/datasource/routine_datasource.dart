import 'dart:convert';
import 'package:project/core/constants/api_url.dart';
import 'package:project/core/error/server_failure.dart';
import 'package:project/features/routine/data/datasource/mock_nomatch_routine.dart';
import 'package:project/features/routine/data/datasource/mock_routine_product.dart';
import 'package:project/features/routine/data/models/no_match_model.dart';
import 'package:project/features/routine/data/models/product_model.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class RoutineRemoteDatasource {
  Future<List<ProductModel>> fetchProductRoutine();
  Future<List<NoMatchModel>> fetchNoMatchRoutine();
  Future<void> deleteProduct(List<int>? productId);
}

class apiServiceRoutine implements RoutineRemoteDatasource {
  final userId = sl<SharedPreferences>().getString("userId") ?? "Default";
  @override
  Future<List<NoMatchModel>> fetchNoMatchRoutine() async {
    final url = Uri.parse("${AppUrl.routine_check_no_match}/${userId}");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        List jsonData = json.decode(res.body);

        return jsonData.map((e) => NoMatchModel.fromJson(e)).toList();
      } else {
        // return [];
        return mockNoMatchData;
        // throw Exception("Fail to load product in user's routine");
      }
    } catch (e) {
      return mockNoMatchData;
    }
  }

  @override
  Future<List<ProductModel>> fetchProductRoutine() async {
    final url = Uri.parse("${AppUrl.routine_check_product}/${userId}");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        List jsonData = json.decode(res.body);

        return jsonData.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        // return [];
        return mockProductData;
        // throw Exception("Fail to load product in user's routine");
      }
    } catch (e) {
      return mockProductData;
    }
  }

  @override
  Future<void> deleteProduct(List<int>? productId) async {
    final url = Uri.parse("${AppUrl.routine_delete_product}/${userId}");
    try {
      final res = await http.delete(url, body: productId);
      print("PRODUCTI : ${productId}");

      if (res.statusCode == 200) {
        print("delete product from routine Succcess");
      } else {
        mockRoutineProduct.removeWhere((product) => product["id"] == "3");
        print("cannot connect with backend");
      }
    } catch (e) {
      print("can not delete product from routine ${e}");
    }
  }
}
