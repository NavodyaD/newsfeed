//auth_repository_impl
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<User> signUpWithEmailPassword(String email, String password) async {
    final result = await datasource.signUpWithEmailPassword(email, password);
    return result.user!;
  }
}


