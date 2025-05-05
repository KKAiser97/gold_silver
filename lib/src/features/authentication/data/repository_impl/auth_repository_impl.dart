import 'package:firebase_auth/firebase_auth.dart';
import 'package:gold_silver/src/features/authentication/data/datasource/auth_service.dart';
import 'package:gold_silver/src/features/authentication/domain/auth_repository.dart';

class AuthServiceRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthServiceRepositoryImpl(this.service);

  @override
  Future<UserCredential?> signInWithGoogle() {
    return service.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return service.signOut();
  }

  @override
  Future<UserCredential?> signInWithEmailAndPassword({String email = '', String password = ''}) {
    return service.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential?> createUserWithEmailAndPassword(
      {String email = '', String password = '', String username = ''}) {
    return service.createUserWithEmailAndPassword(email: email, password: password, username: username);
  }
}
