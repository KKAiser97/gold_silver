import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gold_silver/src/core/injector/locator.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthService {
  Future<UserCredential?> signInWithGoogle();

  Future<UserCredential?> createUserWithEmailAndPassword(
      {String email = '', String password = '', String username = ''});

  Future<UserCredential?> signInWithEmailAndPassword({String email = '', String password = ''});

  Future<void> signOut();
}

class AuthServiceImpl implements AuthService {
  // final _firebaseAuth = FirebaseAuth.instance;
  // final _firebaseFirestore = FirebaseFirestore.instance;

  AuthServiceImpl();

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      log('Google Sign-In error: $e');
      return null;
    }
  }

  @override
  Future<UserCredential?> signInWithEmailAndPassword({String email = '', String password = ''}) async {
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      log('Email Sign-In error: $e');
      return null;
    }
  }

  @override
  Future<UserCredential?> createUserWithEmailAndPassword({
    String email = '',
    String password = '',
    String username = '',
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
      //   'email': event.email,
      //   'username': event.username,
      //   'createdAt': FieldValue.serverTimestamp(),
      // });
      await saveUserToFirestore(userCredential.user!, username);
      return userCredential;
    } catch (e) {
      log('Create User error: $e');
      return null;
    }
  }

  Future<void> saveUserToFirestore(User user, String username) async {
    final docRef = firebaseFirestore.collection('users').doc(user.uid);
    final snapshot = await docRef.get();
    if (!snapshot.exists) {
      await docRef.set({
        'displayName': username,
        'uid': user.uid,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'photoURL': user.photoURL,
        'isEmailVerified': user.emailVerified,
        'isAnonymous': user.isAnonymous,
        'creationTime': user.metadata.creationTime.toString(),
        'lastSignInTime': user.metadata.lastSignInTime.toString(),
        'tenantId': user.tenantId,
        'refreshToken': user.refreshToken,
      });
    }
  }

  // Future<void> sendOtp(String phoneNumber) async {
  //   await _firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       // Auto-complete
  //       await _firebaseAuth.signInWithCredential(credential);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       log("OTP Failed: ${e.message}");
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       // Save `verificationId` để xác nhận sau
  //       this.verificationId = verificationId;
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       this.verificationId = verificationId;
  //     },
  //   );
  // }
  //
  // Future<void> verifyOtp(String otp) async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: this.verificationId,
  //     smsCode: otp,
  //   );
  //   await _firebaseAuth.signInWithCredential(credential);
  // }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }
}
