import 'package:project/features/profile/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> userDetail();
  Future<List<AllergyEntity>> queryAllergy(String query);
  Future<void> updateAllergy(List<int> onAdd, List<int> onDelete);
  Future<void> updateSkinProblem(List<int> onAdd, List<int> onDelete);
  Future<void> updateSkinType(int skinTypeId);
  Future<void> deleteAccount();
}
