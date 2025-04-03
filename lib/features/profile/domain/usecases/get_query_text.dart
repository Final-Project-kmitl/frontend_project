import 'package:project/features/profile/domain/entities/user_entity.dart';
import 'package:project/features/profile/domain/repository/user_repository.dart';

class GetQueryText {
  final UserRepository userRepository;
  GetQueryText({required this.userRepository});
  Future<List<AllergyEntity>> call(String query) async {
    return await userRepository.queryAllergy(query);
  }
}
