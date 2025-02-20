import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User> signUpWithEmailPassword(String email, String password);
  Future<User> loginWithEmailPassword(String email, String password);
}
