import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class GoogleSignInEvent extends AuthEvent {
  const GoogleSignInEvent();
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}
