abstract class UserRepository {
  Future<void> saveUserData(String uid, String name, String email, List<String> interests);
}
