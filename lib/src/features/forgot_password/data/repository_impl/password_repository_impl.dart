import 'package:gold_silver/src/features/forgot_password/data/datasource/password_service.dart';
import 'package:gold_silver/src/features/forgot_password/domain/password_repository.dart';

class PasswordServiceRepositoryImpl implements PasswordRepository {
  final PasswordService service;

  PasswordServiceRepositoryImpl(this.service);

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return service.sendPasswordResetEmail(email);
  }

  @override
  Future<bool> resetPassword({
    String email = '',
    String oldPassword = '',
    String newPassword = '',
    String confirmPassword = '',
  }) {
    return service.resetPassword(
      email: email,
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
