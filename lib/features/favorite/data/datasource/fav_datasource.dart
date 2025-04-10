import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/error/server_failure.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/favorite/data/datasource/fav_mock_data.dart';
import 'package:project/features/favorite/data/models/fav_product_model.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavRemoteDatasource {
  Future<List<FavProductModel>> fetchFavProduct();
  Future<void> unFavProduct(Set<int> productId);
}

class apiServiceFavorite implements FavRemoteDatasource {
  final userId = sl<SharedPreferences>().getString(shared_pref.token);

  final dio = sl<DioClient>();
  //รับข้อมูลที่ user ถูกใต
  @override
  Future<List<FavProductModel>> fetchFavProduct() async {
    final url = Uri.parse(AppUrl.getFavoriteProduct);
    print("URL : $url");

    try {
      final res = await dio.get(url.toString());

      if (res.statusCode == 200) {
        List jsonData = res.data;
        return jsonData.map((e) => FavProductModel.fromJson(e)).toList();
      } else {
        throw Exception("Fail to load Product user Fav");
      }
    } catch (e) {
      print(e.toString());
      return mockFavoriteData.map((e) => FavProductModel.fromJson(e)).toList();
      // throw ServerFailure(e.toString());
    }
  }

  // user unfavorite
  @override
  Future<void> unFavProduct(Set<int> productId) async {
    final url = Uri.parse("${AppUrl.favorite_delete_add}");
    try {
      if (productId.length == 0) {
        print("no product select");
      } else {
        for (int id in productId) {
          final res = await dio.delete(url.toString(), data: {
            "userId": userId,
            "productId": id,
          });
        }
      }
    } catch (e) {
      print(e.toString());
      throw ServerFailure(e.toString());
    }
  }
}
