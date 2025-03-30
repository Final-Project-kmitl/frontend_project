import 'package:project/features/profile/domain/repository/user_repository.dart';

class SkinProblem {
  final UserRepository userRepository;
  SkinProblem({required this.userRepository});

  Future<void> call({required List<int> onAdd, required List<int> onDelete}) {
    return userRepository.updateSkinProblem(onAdd, onDelete);
  }
}
