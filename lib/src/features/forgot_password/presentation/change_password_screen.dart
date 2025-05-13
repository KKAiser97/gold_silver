import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/bloc/password_bloc.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/bloc/password_event.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/bloc/password_state.dart';
import 'package:localization/localization.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordBloc, PasswordState>(
      listener: (context, state) {
        if (state is PwError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is PwReset) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("doi_mat_khau_thanh_cong".i18n())),
          );
          Navigator.pop(context);
        } else if (state is NewPwNotMatch) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("mat_khau_moi_khong_khop".i18n())),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text("doi_mat_khau".i18n())),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: currentPassController,
                  decoration: InputDecoration(labelText: "mat_khau_hien_tai".i18n()),
                  obscureText: true,
                ),
                TextField(
                  controller: newPassController,
                  decoration: InputDecoration(labelText: "mat_khau_moi".i18n()),
                  obscureText: true,
                ),
                TextField(
                  controller: confirmPassController,
                  decoration: InputDecoration(labelText: "xac_nhan_mat_khau".i18n()),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final email = FirebaseAuth.instance.currentUser?.email;
                    context.read<PasswordBloc>().add(
                          ResetPasswordEvent(
                            email: email ?? '',
                            oldPassword: currentPassController.text,
                            newPassword: newPassController.text,
                            confirmPassword: confirmPassController.text,
                          ),
                        );
                  },
                  child: state is PwLoading
                      ? const Padding(padding: EdgeInsets.symmetric(vertical: 4), child: CircularProgressIndicator())
                      : Text("doi_mat_khau".i18n()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
