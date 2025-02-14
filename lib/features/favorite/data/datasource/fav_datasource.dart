import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/core/constants/api_url.dart';
import 'package:project/core/error/server_failure.dart';
import 'package:project/features/favorite/data/datasource/fav_mock_data.dart';
import 'package:project/features/favorite/data/models/fav_product_model.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class FavRemoteDatasource {
  Future<List<FavProductModel>> fetchFavProduct();
  Future<void> unFavProduct(Set<int> productId);
}

class apiServiceFavorite implements FavRemoteDatasource {
  final userId = sl<SharedPreferences>().getString("userId") ?? "Default";
  @override
  Future<List<FavProductModel>> fetchFavProduct() async {
    final url = Uri.parse("${AppUrl.get_fav_product}/${userId}");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        List jsonData = json.decode(res.body);

        return jsonData.map((e) => FavProductModel.fromJson(e)).toList();
      } else {
        print("object1");
        return mockFavoriteData
            .map((e) => FavProductModel.fromJson(e))
            .toList();
        // throw Exception("Fail to load Product user Fav");
      }
    } catch (e) {
      print("obj2");
      return mockFavoriteData.map((e) => FavProductModel.fromJson(e)).toList();
      // throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> unFavProduct(Set<int> productId) async {
    final url = Uri.parse("${AppUrl.unfav}/${userId}");
    try {
      if (productId.length == 0) {
        print("no product select");
      } else {
        print(productId);
        final res = await http.delete(url, body: productId);
      }
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
