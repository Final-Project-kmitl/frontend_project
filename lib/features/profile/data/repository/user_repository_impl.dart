import 'package:project/features/profile/data/datasource/user_datasource.dart';
import 'package:project/features/profile/domain/repository/user_repository.dart';
import 'package:project/features/profile/domain/entities/user_entity.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource userDatasource;

  UserRepositoryImpl(this.userDatasource);
  @override
  Future<UserEntity> userDetail() async {
    return await userDatasource.fetchUserInfo();
  }

  @override
  Future<List<AllergyEntity>> queryAllergy(String query) async {
    return await userDatasource.fetchQueryAllergic(query);
  }

  @override
  Future<void> updateAllergy(List<int> onAdd, List<int> onDelete) {
    return userDatasource.fetchUpdate(onAdd, onDelete);
  }

  @override
  Future<void> updateSkinProblem(List<int> onAdd, List<int> onDelete) {
    return userDatasource.fetechUpdateSkinProblem(onAdd, onDelete);
  }

  @override
  Future<void> updateSkinType(int skinTypeId) {
    return userDatasource.updateSkinType(skinTypeId);
  }

  @override
  Future<void> deleteAccount() {
    return userDatasource.deleteAccount();
  }
}
