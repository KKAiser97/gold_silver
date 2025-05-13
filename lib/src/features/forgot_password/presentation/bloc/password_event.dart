import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object?> get props => [];
}

class ForgetPasswordEvent extends PasswordEvent {
  final String email;

  const ForgetPasswordEvent({this.email = ''});

  @override
  List<Object?> get props => [email];
}

class ResetPasswordEvent extends PasswordEvent {
  final String email;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordEvent({
    this.email = '',
    this.oldPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });

  @override
  List<Object?> get props => [
        email,
        oldPassword,
        newPassword,
        confirmPassword,
      ];
}
