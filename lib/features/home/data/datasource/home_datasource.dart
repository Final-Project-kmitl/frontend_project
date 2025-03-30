import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/home/data/model/filter_model.dart';
import 'package:project/features/home/data/model/product_model.dart';
import 'package:project/features/home/domain/entities/filter_entity.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRemoteDatasource {
  Future<List<ProductEntity>> fetchRecommend();
  Future<List<ProductEntity>> fetchPopular();
  Future<List<ProductEntity>> fetchRecent();
  Future<List<int>> fetchFavProduct();
  Future<String> addFavorite(int productId);
  Future<String> removeFavorite(int productId);
  Future<List<ProductEntity>> fetchMoreProduct(int benefitId, int page);

  Future<MergeReturnFilterByBenefitEntity> fetchByBenefitId(int benefitId);
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
        // แปลง JSON เป็น List<ProductModel>
        List<ProductModel> products =
            jsonData.map((e) => ProductModel.fromJson(e)).toList();

        // ดึงเฉพาะชื่อ brand และเก็บไม่เกิน 5 ตัว
        List<String> brandList =
            products.map((product) => product.brand).toSet().toList();

        if (brandList.length > 5) {
          brandList = brandList.sublist(0, 5); // จำกัดแค่ 5 ตัว
        }
        sl<SharedPreferences>().setStringList(shared_pref.topSearch, brandList);
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
      final res = await dio.get(url.toString());

      if (res.statusCode == 200) {
        List jsonData = res.data;

        return jsonData.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception("Can't fetch data");
      }
    } catch (e) {
      throw Exception("RECENT : ${e.toString()}");
    }
  }

  @override
  Future<List<ProductEntity>> fetchRecommend() async {
    final url = Uri.parse(AppUrl.home_recommend);

    try {
      final res = await dio
          .get(url.toString(), queryParameters: {"limit": 20, "page": 1});

      if (res.statusCode == 200) {
        final jsonData = res.data;
        return (jsonData['data'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Can't fetch data");
      }
    } catch (e) {
      throw Exception("REC : ${e.toString()}");
    }
  }

  @override
  Future<List<int>> fetchFavProduct() async {
    final url = AppUrl.getFavoriteProduct;

    try {
      final res = await dio.get(url);

      if (res.statusCode == 200) {
        List jsonData = res.data;

        final jsonMapData =
            jsonData.map((e) => FavoriteProductModel.fromJson(e)).toList();

        return jsonMapData.map((e) => e.id).toList();
      } else {
        throw Exception("Can't fatch favorite product");
      }
    } catch (e) {
      throw Exception("FAV : ${e.toString()}");
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

      return res.toString();
    } catch (e) {
      throw Exception("Server error");
    }
  }

  @override
  Future<MergeReturnFilterByBenefitEntity> fetchByBenefitId(
      int benefitId) async {
    try {
      final resProduct = await dio.post(AppUrl.product_search,
          data: {"benefitIds": benefitId, "page": 1, "limit": 10});
      final resFilterCount = await dio.post(AppUrl.product_countFilter,
          data: {"benefitIds": benefitId, "page": 1, "limit": 10});

      if (resProduct.statusCode == 200 && resFilterCount.statusCode == 200) {
        return MergeReturnFilterByBenefitModel.fromJson(
            productJson: resProduct.data, filterJson: resFilterCount.data);
      }

      throw Exception("fail fetch data");
    } catch (e) {
      throw Exception("Server error : ${e.toString()}");
    }
  }

  @override
  Future<List<ProductEntity>> fetchMoreProduct(int benefitId, int page) async {
    try {
      final resProduct = await dio.post(AppUrl.product_search,
          data: {"benefitIds": benefitId, "page": page, "limit": 100});

      if (resProduct.statusCode == 200) {
        List jsonData = resProduct.data['data'];

        return jsonData.map((e) => ProductModel.fromJson(e)).toList();
      }

      throw Exception("Fail to load data");
    } catch (e) {
      print("${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
