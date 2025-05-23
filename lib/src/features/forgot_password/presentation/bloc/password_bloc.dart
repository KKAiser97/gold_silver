import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/forgot_password/domain/password_repository.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/bloc/password_event.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/bloc/password_state.dart';
import 'package:localization/localization.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordRepository repository;

  PasswordBloc({required this.repository}) : super(PwInitial()) {
    on<PasswordEvent>((event, emit) async {
      if (event is ForgetPasswordEvent) {
        emit(PwLoading());
        try {
          await repository.sendPasswordResetEmail(event.email);
          emit(LinkResetPwSent());
        } catch (e) {
          emit(PwError(e.toString()));
        }
      }
      if (event is ResetPasswordEvent) {
        if (event.newPassword != event.confirmPassword) {
          emit(NewPwNotMatch());
        } else {
          emit(PwLoading());
          final res = await repository.resetPassword(
            email: event.email,
            oldPassword: event.oldPassword,
            newPassword: event.newPassword,
            confirmPassword: event.confirmPassword,
          );
          emit(res ? PwReset() : PwError("thay_doi_mat_khau_that_bai".i18n()));
        }
      }
    });
  }
}
