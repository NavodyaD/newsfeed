import 'package:cloud_firestore/cloud_firestore.dart';

// Firebase data source - Save user data to firestore collection
class FirebaseFirestoreDatasource {
  final FirebaseFirestore firestore;

  FirebaseFirestoreDatasource(this.firestore);

  Future<void> saveUserData(String uid, String name, String email, List<String> interests) async {
    await firestore.collection('UserDetails').doc(uid).set({
      'name': name,
      'email': email,
      'userId': uid,
      'interests': interests,
    });
  }
}
