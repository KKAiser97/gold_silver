import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/bloc/password_bloc.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/bloc/password_event.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/bloc/password_state.dart';
import 'package:localization/localization.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('forgot_password'.i18n()),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: SvgPicture.asset('assets/svgs/ic_arrow_back.svg'),
        ),
      ),
      body: BlocConsumer<PasswordBloc, PasswordState>(
        listener: (context, state) {
          if (state is PwError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is LinkResetPwSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('link_forgot_password_has_been_sent'.i18n())),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('enter_email_forgot_password'.i18n()),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () =>
                        context.read<PasswordBloc>().add(ForgetPasswordEvent(email: emailController.text.trim())),
                    child: Text('send_link_forgot_password'.i18n())),
                if (state is PwLoading) ...[
                  const SizedBox(height: 16),
                  const CircularProgressIndicator(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
