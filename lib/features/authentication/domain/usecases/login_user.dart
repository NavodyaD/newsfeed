import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  Future<User> call(String email, String password) async {
    final user = await authRepository.loginWithEmailPassword(email, password);
    return user;
  }
}
