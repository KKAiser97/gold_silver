import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/core/injector/locator.dart';
import 'package:gold_silver/src/features/authentication/domain/auth_repository.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_state.dart';

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
    await FirebaseAuth.instance.signOut().then((value) => emit(AuthInitial()));
  }

  void loginWithBiometric() {}
}
