import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/core/injector/locator.dart';
import 'package:gold_silver/src/features/authentication/domain/auth_repository.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_state.dart';
import 'package:gold_silver/src/utils/router/app_router.dart';
import 'package:localization/localization.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    on<CheckUserEvent>(_onCheckUser);
    on<SignOutEvent>(_onSignOut);
  }

  User? get user => firebaseAuth.currentUser;

  // Future<void> _onGoogleSignIn(GoogleSignInEvent event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //
  //   try {
  //     final response = await repository.signInWithGoogle();
  //     if (response != null) {
  //       emit(AuthLoaded(response.user));
  //     } else {
  //       emit(const AuthError('Failed to sign in'));
  //     }
  //   } catch (e) {
  //     emit(AuthError('Failed to sign in: $e'));
  //   }
  // }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      final credential = await repository.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
        username: event.username,
      );

      if (credential?.user != null) {
        emit(AuthLoaded(user));
      }
    } catch (e) {
      emit(AuthError('Failed to register: $e'));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      UserCredential? userCredential = await repository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (userCredential != null) {
        emit(AuthLoaded(user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onCheckUser(CheckUserEvent event, Emitter<AuthState> emit) {
    if (user != null) {
      emit(AuthLoaded(user));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      /// showDialog function returns a bool indicating the user's choice (true: "Có", false: "Không")
      final shouldSignOut = await showDialog<bool>(
        context: AppRouter.context!,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('logout'.i18n()),
            content: Text('ensure_to_logout'.i18n()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('no'.i18n()),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('yes'.i18n()),
              ),
            ],
          );
        },
      );

      ///MARK: Do not call emit() function inside the dialog's onPressed() callback, the state may not update because of incorrect context
      if (shouldSignOut == true) {
        await repository.signOut();
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void loginWithBiometric() {}
}
