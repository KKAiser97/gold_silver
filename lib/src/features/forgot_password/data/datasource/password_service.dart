import 'package:firebase_auth/firebase_auth.dart';
import 'package:gold_silver/src/core/injector/locator.dart';

abstract class PasswordService {
  Future<void> sendPasswordResetEmail(String email);

  Future<bool> resetPassword(
      {String email = '', String oldPassword = '', String newPassword = '', String confirmPassword = ''});
}

class PasswordServiceImpl implements PasswordService {
  PasswordServiceImpl();

  @override
  Future<void> sendPasswordResetEmail(String email) {
    try {
      return firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> resetPassword({
    String email = '',
    String oldPassword = '',
    String newPassword = '',
    String confirmPassword = '',
  }) async {
    final user = firebaseAuth.currentUser;
    if (user?.email == null) return false;

    try {
      // Xác thực lại người dùng
      final cred = EmailAuthProvider.credential(email: user!.email!, password: oldPassword);
      await user.reauthenticateWithCredential(cred);

      await user.updatePassword(newPassword);
      return true;
    } catch (e) {
      return false;
    }
  }
}
