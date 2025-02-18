// user model
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;

  UserModel({required this.uid});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(uid: user.uid);
  }
}
