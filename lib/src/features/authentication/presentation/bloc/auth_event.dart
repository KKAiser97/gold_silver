import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const RegisterEvent({
    this.email = '',
    this.password = '',
    this.username = '',
  });

  @override
  List<Object?> get props => [email, password, username];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    this.email = '',
    this.password = '',
  });

  @override
  List<Object?> get props => [email, password];
}

class GoogleSignInEvent extends AuthEvent {
  const GoogleSignInEvent();
}

class CheckUserEvent extends AuthEvent {
  const CheckUserEvent();
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}
