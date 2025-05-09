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
