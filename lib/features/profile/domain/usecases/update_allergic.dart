import 'package:project/features/profile/domain/repository/user_repository.dart';

class UpdateAllergic {
  final UserRepository userRepository;
  UpdateAllergic({required this.userRepository});

  Future<void> call({required List<int> onAdd, required List<int> onDelete}) {
    print("In use case : add ${onAdd} delete ${onDelete}");
    return userRepository.updateAllergy(onAdd, onDelete);
  }
}
