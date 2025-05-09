import 'package:gold_silver/src/core/injector/locator.dart';

abstract class PasswordService {
  Future<void> sendPasswordResetEmail(String email);
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
}
