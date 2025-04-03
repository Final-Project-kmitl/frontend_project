import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/auth/data/models/ingredient_model.dart';
import 'package:project/features/auth/domain/entities/ingredient_entity.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthApiService {
  Future<List<IngredientEntity>> fetchIngredient(String ingredientName);
  Future<void> fetchUser(int userId, String skinType, List<int>? allergicListId,
      List<int> benefitListId);
}

class apiServiceAuth implements AuthApiService {
  final dio = sl<DioClient>();

  //การจัการในเรื่องของการเรียก ingredient ตามการ search เพื่อทำ autocomplete
  @override
  Future<List<IngredientEntity>> fetchIngredient(String ingredientName) async {
    final url = Uri.parse(AppUrl.ingredient_search);

    try {
      final res = await dio.get(url.toString(),
          queryParameters: {"name": ingredientName, "limit": 100});

      if (res.statusCode == 200) {
        List jsonData = res.data['data'] ?? [];

        return jsonData.map((e) => IngredientModel.fromJson(e)).toList();
      }
      throw Exception("Failed to load data: ${res.statusCode}");
    } catch (e) {
      return [];
    }
  }

//fetch ข้อมุลของแอพ
  @override
  Future<void> fetchUser(int userId, String skinType, List<int>? allergicListId,
      List<int> benefitListId) async {
    print(userId);
    final url = Uri.parse(AppUrl.user);
    int? skinId;

    //map ข้อมูลเป้นรูปแบบ id เพราะ api รับข้อมูลเป้น id
    switch (skinType) {
      case "ผิวปกติ":
        skinId = 1;
        break;
      case "ผิวผสม":
        skinId = 2;
        break;
      case "ผิวมัน":
        skinId = 3;
        break;
      case "ผิวแห้ง":
        skinId = 4;
        break;
      case "ไม่ทราบ":
        skinId = null; // ❌ ไม่ต้องส่งค่า
        break;
    }
    print(skinId);

    try {
      final registerRes = await dio.post("${AppUrl.register}",
          data: {"userId": userId, "skinTypeId": skinId});

      sl<SharedPreferences>()
          .setString(shared_pref.userId, registerRes.data['userId'].toString());
      sl<SharedPreferences>()
          .setString(shared_pref.token, registerRes.data['accessToken']);

      final allergic = await dio.post("${AppUrl.profile_ingredient}",
          data: {"userId": userId, "ingredientIds": allergicListId});

      final skinPro = await dio.post("${AppUrl.profile_skin_problem}",
          data: {"userId": userId, "skinProblemIds": benefitListId});

      // final res = await dio.post(url.toString(), data: body);

      sl<SharedPreferences>().setString(shared_pref.userId, userId.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
