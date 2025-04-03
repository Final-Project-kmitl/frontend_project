import 'package:project/features/profile/domain/repository/user_repository.dart';

class UpdateSkinType {
  final UserRepository userRepository;
  UpdateSkinType({required this.userRepository});

  Future<void> call(int skinType) {
    return userRepository.updateSkinType(skinType);
  }
}
