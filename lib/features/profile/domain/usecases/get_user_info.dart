import 'package:project/features/profile/domain/entities/user_entity.dart';
import 'package:project/features/profile/domain/repository/user_repository.dart';

class GetUserInfo {
  final UserRepository userRepository;

  GetUserInfo({required this.userRepository});

  Future<UserEntity> call() {
    return userRepository.userDetail();
  }
}
