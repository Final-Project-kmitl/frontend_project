import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/home/data/model/product_model.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRemoteDatasource {
  Future<List<ProductEntity>> fetchRecommend();
  Future<List<ProductEntity>> fetchPopular();
  Future<List<ProductEntity>> fetchRecent();
  Future<List<FavoriteProductEntity>> fetchFavProduct();
  Future<String> addFavorite(int productId);
  Future<String> removeFavorite(int productId);
}

class apiServiceHome implements HomeRemoteDatasource {
  final userId = sl<SharedPreferences>().getString(shared_pref.userId);
  final dio = sl<DioClient>();
  @override
  Future<List<ProductEntity>> fetchPopular() async {
    final url = Uri.parse(AppUrl.home_popular);

    try {
      final res = await dio.get(url.toString());

      if (res.statusCode == 200) {
        List jsonData = res.data;
        return jsonData.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception("Can't fetch data");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> fetchRecent() async {
    final url = Uri.parse(AppUrl.home_recent);

    try {
      final res =
          await dio.get(url.toString(), queryParameters: {"userId": userId});

      if (res.statusCode == 200) {
        List jsonData = res.data;

        return jsonData.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception("Can't fetch data");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> fetchRecommend() async {
    final url = Uri.parse(AppUrl.home_recommend);

    try {
      final res =
          await dio.get(url.toString(), queryParameters: {"userId": userId});

      if (res.statusCode == 200) {
        List jsonData = res.data;
        return jsonData.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception("Can't fetch data");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<FavoriteProductEntity>> fetchFavProduct() async {
    final url = AppUrl.getFavoriteProduct(userId.toString());

    try {
      final res = await dio.get(url);

      if (res.statusCode == 200) {
        List jsonData = res.data;
        return jsonData.map((e) => FavoriteProductModel.fromJson(e)).toList();
      } else {
        throw Exception("Can't fatch favorite product");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> addFavorite(int productId) async {
    final url = Uri.parse(AppUrl.home_favorite);

    try {
      final res = await dio.post(url.toString(), data: {
        "userId": userId,
        "productId": productId,
      });

      if (res.statusCode == 201) {
        return "Add product from favorite";
      } else {
        throw Exception("Can't remove product");
      }
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }

  @override
  Future<String> removeFavorite(int productId) async {
    final url = Uri.parse(AppUrl.home_favorite);

    try {
      final res = await dio.delete(url.toString(), data: {
        "userId": userId,
        "productId": productId,
      });

      print(res);

      return res.toString();
    } catch (e) {
      throw Exception("Server error");
    }
  }
}
