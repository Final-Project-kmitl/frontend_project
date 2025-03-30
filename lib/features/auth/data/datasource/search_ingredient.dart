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

  //จัดการ body เพื่อให้่้สำหรับการส่งข้อมูลไป backend
    final Map<String, dynamic> body = {
      "userId": userId,
      if (skinId != null)
        "skinTypeId": skinId, // ✅ ถ้า skinId เป็น null จะไม่ถูกเพิ่ม
      "skinProblemIds": benefitListId ?? [], // ป้องกัน null
      "ingredientIds": allergicListId ?? [],
    };
    try {
      final res = await dio.post(url.toString(), data: body);

      if (res.statusCode == 201) {
        sl<SharedPreferences>()
            .setString(shared_pref.userId, userId.toString());
      }

    } catch (e) {
      throw Exception("");
    }
  }
}
