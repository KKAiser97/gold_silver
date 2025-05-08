import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_state.dart';
import 'package:gold_silver/src/theme/theme.dart';
import 'package:gold_silver/src/utils/constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoaded) {
            Navigator.pushReplacementNamed(context, Routes.main);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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
              const SizedBox(height: 16),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.schemeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // Reduced border radius
                    ),
                  ),
                  onPressed: () => context
                      .read<AuthBloc>()
                      .add(LoginEvent(email: emailCtrl.text.trim(), password: passwordCtrl.text.trim())),
                  child: const Text('Đăng nhập')),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Chưa có tài khoản?'),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },
                  child: const Text('Đăng ký'),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
