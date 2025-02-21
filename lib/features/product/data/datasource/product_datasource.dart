import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/product/data/model/product_model.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductDatasource {
  Future<ProductModel> fetchProduct(int productId);
}

class apiServiceProduct implements ProductDatasource {
  final userId = sl<SharedPreferences>().getString(shared_pref.userId);
  final dio = sl<DioClient>();
  @override
  Future<ProductModel> fetchProduct(int productId) async {
    final url = Uri.parse("${AppUrl.product_detail}/${productId}");

    try {
      final res =
          await dio.get(url.toString(), queryParameters: {"userId": userId});

      if (res.statusCode == 200) {
        final jsonData = res.data;

        return ProductModel.fromJson(jsonData);
      } else {
        throw Exception("Can't get product detail");
      }
    } catch (e) {
      throw Exception("Server error : ${e.toString()}");
    }
  }
}
