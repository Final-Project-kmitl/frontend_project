import 'package:project/features/profile/domain/repository/user_repository.dart';

class DeleteAccount {
  final UserRepository userRepository;

  DeleteAccount({required this.userRepository});

  Future<void> call() {
    return userRepository.deleteAccount();
  }
}
