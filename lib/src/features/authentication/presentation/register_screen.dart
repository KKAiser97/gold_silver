import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_state.dart';
import 'package:gold_silver/src/theme/theme.dart';
import 'package:gold_silver/src/utils/constants.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          Navigator.pushReplacementNamed(context, Routes.main);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Đăng ký')),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.schemeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6), // Reduced border radius
                ),
              ),
              onPressed: () => context.read<AuthBloc>().add(RegisterEvent(
                    email: emailCtrl.text.trim(),
                    password: passwordCtrl.text.trim(),
                    username: usernameCtrl.text.trim(),
                  )),
              child: const Text('Đăng ký')),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: usernameCtrl,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
