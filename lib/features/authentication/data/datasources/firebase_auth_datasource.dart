// datasource
import 'package:firebase_auth/firebase_auth.dart';

// Firebase data source - Create user in firebase auth
class FirebaseAuthDatasource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDatasource(this.firebaseAuth);

  Future<UserCredential> signUpWithEmailPassword(String email, String password) {
    return firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
