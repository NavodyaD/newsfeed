// usecase
import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

class SignUpUser {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SignUpUser(this.authRepository, this.userRepository);

  Future<User> call(String email, String password, String name, List<String> interests) async {
    final user = await authRepository.signUpWithEmailPassword(email, password);
    await userRepository.saveUserData(user.uid, name, email, interests);
    return user;
  }
}
