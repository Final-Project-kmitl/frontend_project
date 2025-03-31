import 'package:dio/dio.dart';
import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/product/data/model/product_model.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductDatasource {
  Future<ProductModel> fetchProduct(int productId);
  Future<void> removeFavorite(int productId);
  Future<void> addFavorite(int productId);
  Future<void> addRoutine(int productId);
}

class apiServiceProduct implements ProductDatasource {
  final userId = sl<SharedPreferences>().getString(shared_pref.userId);
  final dio = sl<DioClient>();
  @override
  Future<ProductModel> fetchProduct(int productId) async {
    if (userId == null) {
      throw Exception("User ID not found in SharedPreferences");
    }

    try {
      // 🔹 ดึงข้อมูลสินค้า
      final productRes = await dio.get(
        "${AppUrl.product_detail}/$productId",
      );

      if (productRes.statusCode != 200) {
        throw Exception("Failed to fetch product details");
      }

      // ✅ ตรวจสอบว่าข้อมูลสินค้าเป็น Map
      if (productRes.data is! Map<String, dynamic>) {
        throw Exception("Invalid product data format");
      }

      final productData = productRes.data as Map<String, dynamic>;

      // 🔹 ดึงรายการสินค้าที่ Favorite
      final favoriteRes = await dio.get(AppUrl.getFavoriteProduct);

      if (favoriteRes.statusCode != 200) {
        throw Exception("Failed to fetch favorite products");
      }

      // ✅ ตรวจสอบว่า favoriteRes เป็น List
      if (favoriteRes.data is! List<dynamic>) {
        throw Exception("Invalid favorite data format");
      }

      final resProductRelate =
          await dio.get("${AppUrl.product_relate}/${productId}");

      final productRelate = (resProductRelate.data['items'] as List)
          .map((e) => ProductRelateModel.fromJson(e))
          .toList();

      final favoriteList = List<Map<String, dynamic>>.from(favoriteRes.data);

      // 🔹 เช็คว่าสินค้านี้อยู่ใน Favorite หรือไม่
      final bool isFavorite = favoriteList.any((fav) => fav['id'] == productId);

      bool _isRoutine = false;
      int _routineCount = 0;

      try {
        final routineRes = await dio.get("${AppUrl.baseUrl}/routine/${userId}");

        final routineList = List<Map<String, dynamic>>.from(routineRes.data);

        _isRoutine = routineList.any((routine) => routine["id"] == productId);

        _routineCount = routineList.length;
      } catch (e) {
        if (e is DioException && e.response?.statusCode == 404) {
          _isRoutine = false;
          _routineCount = 0;
        } else {
          throw Exception("Routine ERror : $e");
        }
      }

      print("RELATE   :   ${productRelate}");

      return ProductModel.fromJson(productData).copyWith(
          isFav: isFavorite,
          isRoutine: _isRoutine,
          routineCount: _routineCount,
          product: productRelate);
    } catch (e) {
      throw Exception("Server error : ${e.toString()}");
    }
  }

  @override
  Future<void> addFavorite(int productId) async {
    print("ADD");
    try {
      // Check if userId is null
      if (userId == null) {
        throw Exception("User ID is not available");
      }

      final res = await dio.post(AppUrl.favorite_delete_add,
          data: {"userId": userId, "productId": productId});

      print(res.statusCode);
    } catch (e) {
      print("❌ Failed to update favorite: ${e}");
      throw Exception("Server error: ${e.toString()}");
    }
  }

  @override
  Future<void> removeFavorite(int productId) async {
    print("REMOVE");
    try {
      final res = await dio.delete(AppUrl.favorite_delete_add,
          data: {"userId": userId, "productId": productId});

      if (res.statusCode != 200) {
        throw Exception("Can't unfavorite product");
      }
    } catch (e) {
      throw Exception("Server error : ${e.toString()}");
    }
  }

  @override
  Future<void> addRoutine(int productId) async {
    try {
      final res =
          await dio.post("${AppUrl.routine_check_product}/$userId/$productId");
      print(res);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
