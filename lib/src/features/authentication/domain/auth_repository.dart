import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential?> signInWithGoogle();

  Future<UserCredential?> createUserWithEmailAndPassword(
      {String email = '', String password = '', String username = ''});

  Future<UserCredential?> signInWithEmailAndPassword({String email = '', String password = ''});

  Future<void> signOut();
}
