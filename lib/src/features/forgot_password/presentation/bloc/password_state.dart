import 'package:equatable/equatable.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object?> get props => [];
}

class PwInitial extends PasswordState {}

class PwLoading extends PasswordState {}

class LinkResetPwSent extends PasswordState {}

class NewPwNotMatch extends PasswordState {}

class PwReset extends PasswordState {}

class PwError extends PasswordState {
  final String message;
  final DateTime timestamp;

  ///MARK: Added timestamp to guarantee uniqueness of error state (bloc compares old state with new state to trigger UI update)

  PwError(this.message) : timestamp = DateTime.now();

  @override
  List<Object?> get props => [message, timestamp];
}
