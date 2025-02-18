// usecase
import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';

class SignUpUser {
  final AuthRepository repository;

  SignUpUser(this.repository);

  Future<User> call(String email, String password) {
    return repository.signUpWithEmailPassword(email, password);
  }
}
