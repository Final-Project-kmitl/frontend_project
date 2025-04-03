import 'package:project/core/constants/api_url.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/profile/data/model/allergy_model.dart';
import 'package:project/features/profile/data/model/user_model.dart';
import 'package:project/features/profile/domain/entities/user_entity.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserDatasource {
  Future<UserEntity> fetchUserInfo();
  Future<void> fetechUpdateSkinProblem(List<int> onAdd, List<int> onDelete);
  Future<List<AllergyEntity>> fetchQueryAllergic(String query);
  Future<void> fetchUpdate(List<int> onAdd, List<int> onDelete);
  Future<void> updateSkinType(int skinTypeId);
  Future<void> deleteAccount();
}

class ApiServiceUser implements UserDatasource {
  final dio = sl<DioClient>();
  final userId = sl<SharedPreferences>().getString(shared_pref.userId);
  @override
  Future<UserEntity> fetchUserInfo() async {
    print("START");
    if (userId == "") {
      throw Exception("User Id not found in SharedPref");
    }
    final url = Uri.parse("${AppUrl.profile_user}");
    try {
      final res = await dio.get(url.toString());

      if (res.statusCode != 200) {
        throw Exception("Failed to fetch user info");
      }
      return UserModel.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw Exception("Server error : ${e.toString()}");
    }
  }

  @override
  Future<List<AllergyEntity>> fetchQueryAllergic(String query) async {
    // TODO: implement fetchQueryAllergic
    final url = Uri.parse("${AppUrl.ingredient_search}");
    try {
      final res = await dio
          .get(url.toString(), queryParameters: {"name": query, "limit": 100});

      List jsonData = res.data['data'];

      if (res.statusCode == 200) {
        return jsonData.map((e) => AllergyModel.fromJson(e)).toList();
      }

      throw Exception("ERROR");
    } catch (e) {
      throw Exception("Server error : ${e.toString()}");
    }
  }

  @override
  Future<void> fetchUpdate(List<int> onAdd, List<int> onDelete) async {
    try {
      await dio.post("${AppUrl.profile_ingredient}",
          data: {"userId": userId, "ingredientIds": onAdd});
    } catch (e) {
      throw Exception("OnAdd Error : ${e.toString()}");
    }

    for (int ingreId in onDelete) {
      try {
        await dio.delete("${AppUrl.profile_ingredient}",
            data: {"ingredientId": ingreId});
      } catch (e) {
        throw Exception(e.toString());
      }
    }
  }

  @override
  Future<void> fetechUpdateSkinProblem(
      List<int> onAdd, List<int> onDelete) async {
    try {
      if (onAdd.isNotEmpty) {
        try {
          await dio.post("${AppUrl.profile_skin_problem}",
              data: {"userId": userId, "skinProblemIds": onAdd});
        } catch (e) {
          throw Exception("On add error :${e.toString()}");
        }
      }

      if (onDelete.isNotEmpty) {
        for (int skinId in onDelete) {
          try {
            await dio.delete("${AppUrl.profile_skin_problem}",
                data: {"problemId": skinId});
          } catch (e) {
            throw Exception(e.toString());
          }
        }
      }
    } catch (e) {
      throw Exception("OnAdd Error : ${e.toString()}");
    }
  }

  @override
  Future<void> updateSkinType(int skinTypeId) async {
    try {
      if (skinTypeId == 5) {
        await dio.delete(AppUrl.profile_skin_type);
      } else {
        await dio.post(AppUrl.profile_skin_type,
            data: {"userId": userId, "skinTypeId": skinTypeId});
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final message = await dio.delete(AppUrl.delete_user_account);
    } catch (e) {
      throw Exception("Error : $e");
    }
  }
}
