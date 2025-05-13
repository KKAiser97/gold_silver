abstract class PasswordRepository {
  Future<void> sendPasswordResetEmail(String email);

  Future<bool> resetPassword(
      {String email = '', String oldPassword = '', String newPassword = '', String confirmPassword = ''});
}
