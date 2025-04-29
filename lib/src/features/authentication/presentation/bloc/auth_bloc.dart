import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/authentication/domain/auth_repository.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<GoogleSignInEvent>(_onGoogleSignIn);
  }

  Future<void> _onGoogleSignIn(GoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await repository.signInWithGoogle();
      if (response != null) {
        emit(AuthLoaded(response));
      } else {
        emit(const AuthError('Failed to sign in'));
      }
    } catch (e) {
      emit(AuthError('Failed to sign in: $e'));
    }
  }

  void clearSession() {}

  void loginWithBiometric() {}
}
