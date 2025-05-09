abstract class PasswordRepository {
  Future<void> sendPasswordResetEmail(String email);
}
