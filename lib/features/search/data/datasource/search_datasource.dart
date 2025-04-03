import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/search/data/models/auto_complete_model.dart';
import 'package:project/features/search/data/models/count_filter_model.dart';
import 'package:project/features/search/data/models/product_model.dart';
import 'package:project/features/search/domain/entities/auto_complete_entity.dart';
import 'package:project/features/search/domain/entities/count_filter_entity.dart';
import 'package:project/features/search/domain/entities/search_entity.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SearchDatasource {
  Future<List<AutoCompleteEntity>> fetchBySearch(String searchText);
  Future<SubmitReturnEntity> getCountFilter(
      String params,
      int page,
      int limit,
      int? minPrice,
      int? maxPrice,
      List<int>? skinTypeIds,
      List<int>? benefitIds,
      List<int>? productTypeIds,
      List<int>? skinProblemIds,
      List<String>? brands);
  Future<List<ProductEntity>> getSearchBybenefit(
      String params,
      int page,
      int limit,
      int? minPrice,
      int? maxPrice,
      List<int>? skinTypeIds,
      List<int>? benefitIds,
      List<int>? productTypeIds,
      List<int>? skinProblemIds,
      List<String>? brands);
}

class apiService implements SearchDatasource {
  final dio = sl<DioClient>();
  final userId = sl<SharedPreferences>().getString(shared_pref.userId);
  @override
  Future<List<AutoCompleteEntity>> fetchBySearch(String searchText) async {
    final url = Uri.parse(AppUrl.search_autocomplete);

    try {
      final res = await dio.get(url.toString(),
          queryParameters: {"searchText": searchText, "limit": 100});

      if (res.statusCode == 200) {
        List jsonData = res.data['data'] as List;
        return jsonData.map((e) => AutoCompleteModel.fromJson(e)).toList();
      }

      throw Exception("can't get data");
    } catch (e) {
      throw Exception("Server error : ${e.toString()}");
    }
  }

  @override
  Future<SubmitReturnEntity> getCountFilter(
      String params,
      int page,
      int limit,
      int? minPrice,
      int? maxPrice,
      List<int>? skinTypeIds,
      List<int>? benefitIds,
      List<int>? productTypeIds,
      List<int>? skinProblemIds,
      List<String>? brands) async {
    final searchUrl = Uri.parse(AppUrl.product_search);
    final countFilterUrl = Uri.parse(AppUrl.product_countFilter);

    final data = {
      if (minPrice != null) "minPrice": minPrice,
      if (maxPrice != null) "maxPrice": maxPrice,
      if (skinTypeIds != null && skinTypeIds.isNotEmpty)
        "skinTypeIds": skinTypeIds,
      if (benefitIds != null && benefitIds.isNotEmpty) "benefitIds": benefitIds,
      if (productTypeIds != null && productTypeIds.isNotEmpty)
        "productTypeIds": productTypeIds,
      if (skinProblemIds != null && skinProblemIds.isNotEmpty)
        "skinProblemIds": skinProblemIds,
      if (brands != null && brands.isNotEmpty) "brands": brands,
      "searchText": params,
      "page": page,
      "limit": 300,
    };

    try {
      final res = await Future.wait([
        dio.post(searchUrl.toString(), data: data),
        dio.post(countFilterUrl.toString(), data: data),
      ]);

      final productRes = res[0];
      final countFilterRes = res[1];

      if (productRes.statusCode == 200 && countFilterRes.statusCode == 200) {
        List<ProductEntity> products = (productRes.data['data'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();

        CountFilterEntity countFilter =
            CountFilterModel.fromJson(countFilterRes.data);

        return SubmitReturnModel(countFilter: countFilter, products: products);
      } else {
        throw Exception(
            "API error: ${productRes.statusCode}, ${countFilterRes.statusCode}");
      }
    } catch (e) {
      throw Exception("Server error : ${e.toString()}");
    }
  }

  @override
  Future<List<ProductEntity>> getSearchBybenefit(
      String params,
      int page,
      int limit,
      int? minPrice,
      int? maxPrice,
      List<int>? skinTypeIds,
      List<int>? benefitIds,
      List<int>? productTypeIds,
      List<int>? skinProblemIds,
      List<String>? brands) async {
    final searchUrl = Uri.parse(AppUrl.product_search);

    final data = {
      if (minPrice != null) "minPrice": minPrice,
      if (maxPrice != null) "maxPrice": maxPrice,
      if (skinTypeIds != null && skinTypeIds.isNotEmpty)
        "skinTypeIds": skinTypeIds,
      if (benefitIds != null && benefitIds.isNotEmpty) "benefitIds": benefitIds,
      if (productTypeIds != null && productTypeIds.isNotEmpty)
        "productTypeIds": productTypeIds,
      if (skinProblemIds != null && skinProblemIds.isNotEmpty)
        "skinProblemIds": skinProblemIds,
      if (brands != null && brands.isNotEmpty) "brands": brands,
      "searchText": params,
      "page": page,
      "limit": 300,
    };

    try {
      print(data);
      final res = await dio.post(searchUrl.toString(), data: data);
      if (res.statusCode == 200) {
        List<ProductEntity> jsonData = (res.data['data'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        return jsonData;
      }
      throw Exception("error");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
