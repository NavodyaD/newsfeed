import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl(this.firestore);

  @override
  Future<void> saveUserData(String uid, String name, String email, List<String> interests) async {
    try {
      await firestore.collection('Users').doc(uid).set({
        'name': name,
        'email': email,
        'userId': uid,
        'interests': interests,
      });
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }
}
