import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  // final UserCredential userCredential;
  final User? user;

  const AuthLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;
  final DateTime timestamp;

  /// Added timestamp to guarantee uniqueness of error state (bloc compares old state with new state to trigger UI update)

  AuthError(this.message) : timestamp = DateTime.now();

  @override
  List<Object?> get props => [message, timestamp];
}
