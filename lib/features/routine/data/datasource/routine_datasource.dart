import 'package:dio/dio.dart';
import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/routine/data/models/no_match_model.dart';
import 'package:project/features/routine/data/models/product_model.dart';
import 'package:project/features/routine/domain/entities/product_entity.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RoutineRemoteDatasource {
  Future<List<ProductModel>> fetchProductRoutine();
  Future<List<NoMatchModel>> fetchNoMatchRoutine();
  Future<void> deleteProduct(Set<int> productId);
  Future<Map<String, dynamic>> queryProduct(String query);
  Future<List<ProductEntity>> queryMoreProduct(int page, String query);
  Future<void> addProduct(int productId);
}

class apiServiceRoutine implements RoutineRemoteDatasource {
  final dio = sl<DioClient>();
  final userId =
      sl<SharedPreferences>().getString(shared_pref.userId) ?? "Default";

  @override
  Future<List<NoMatchModel>> fetchNoMatchRoutine() async {
    final url = Uri.parse("${AppUrl.routine_check_no_match}/${userId}");

    try {
      final res = await dio.get(url.toString(), options: Options(
        validateStatus: (status) {
          return status! < 500;
        },
      ));

      if (res.statusCode == 200) {
        List jsonData = res.data;

        print("JSON no match: ${jsonData}");

        return jsonData.map((e) => NoMatchModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        return [];
      } else {
        // return [];
        throw Exception("Fail to load product in user's routine");
      }
    } catch (e) {
      throw Exception("Fail to load product in user's");
    }
  }

  @override
  Future<List<ProductModel>> fetchProductRoutine() async {
    final url = Uri.parse("${AppUrl.routine_check_product}/${userId}");

    try {
      final res = await dio.get(url.toString(), options: Options(
        validateStatus: (status) {
          return status! < 500;
        },
      ));
      if (res.statusCode == 200) {
        List jsonData = res.data;

        print("JSON : ${jsonData}");

        return jsonData.map((e) => ProductModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        return [];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("server error : ${e}");
      // return mockProductData;
    }
  }

  @override
  Future<void> deleteProduct(Set<int> productId) async {
    print("💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡pre : ${productId}");
    if (productId.isEmpty) {
      print("❌ ไม่มีสินค้าให้ลบ");
      return;
    }

    for (var id in productId) {
      final url = Uri.parse("${AppUrl.routine_check_product}/${userId}/${id}");

      try {
        final res = await dio.delete(url.toString(), options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ));

        print("res : ${res.toString()}");
      } catch (e) {
        throw Exception("Server error : ${e.toString()}");
      }
    }
  }

  @override
  Future<Map<String, dynamic>> queryProduct(String query) async {
    try {
      final res = await dio.post(AppUrl.product_search,
          data: {"searchText": query, "page": 1, "limit": 20});

      List jsonData = res.data["data"];
      List routineData = [];

      try {
        final routineRes = await dio
            .get("${AppUrl.routine_check_product}/${userId}", options: Options(
          validateStatus: (status) {
            return status == 200 || status == 404;
          },
        ));
        if (routineRes.statusCode == 200) {
          routineData = routineRes.data;
        } else {
          routineData = [];
        }
      } catch (e, stackTrace) {
        print("Error fetching routine data 1: $e");
        print(stackTrace); // ช่วย Debug เพิ่มเติมหากมีปัญหา
        throw Exception("Failed to load routine data");
      }

      Set<int> routineIds = routineData.map<int>((e) => e["id"]).toSet();

      List<ProductEntity> products = jsonData
          .map((e) => ProductModel.fromJson(e)
              .copyWith(isRoutine: routineIds.contains(e['id'])))
          .toList();

      return {"products": products, "count": routineIds.length};
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> queryMoreProduct(int page, String query) async {
    print("QQQQQ : ${query} <<<< $page");
    try {
      final res = await dio.post(AppUrl.product_search,
          data: {"searchText": query, "page": page, "limit": 20});

      List jsonData = res.data['data'];
      List routineData = [];

      try {
        final routineRes = await dio
            .get("${AppUrl.routine_check_product}/${userId}", options: Options(
          validateStatus: (status) {
            return status == 200 || status == 404;
          },
        ));
        if (routineRes.statusCode == 200) {
          routineData = routineRes.data;
        } else {
          routineData = [];
        }
      } catch (e, stackTrace) {
        print("Error fetching routine data 2: $e");
        print(stackTrace); // ช่วย Debug เพิ่มเติมหากมีปัญหา
        throw Exception("Failed to load routine data");
      }

      Set<int> routineIds = routineData.map<int>((e) => e["id"]).toSet();

      return jsonData.map((e) {
        return ProductModel.fromJson(e).copyWith(
          isRoutine: routineIds.contains(e["id"]),
        );
      }).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addProduct(int productId) async {
    try {
      final res = await dio.post(
        "${AppUrl.routine_check_product}/${userId}/${productId}",
      );
      print(res);
    } catch (e) {
      print(e.toString());
    }
  }
}
