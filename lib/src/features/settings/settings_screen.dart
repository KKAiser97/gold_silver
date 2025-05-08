import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_state.dart';
import 'package:gold_silver/src/utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'User: ${context.read<AuthBloc>().user?.email ?? ''}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Đổi mật khẩu'),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.notifications_active),
            title: Text('Cài đặt thông báo'),
          ),
          const Divider(),
          ListTile(
            onTap: () => context.read<AuthBloc>().add(const SignOutEvent()),
            leading: const Icon(Icons.login),
            title: Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }
}
