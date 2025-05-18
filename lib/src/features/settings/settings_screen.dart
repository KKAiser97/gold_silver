import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_state.dart';
import 'package:gold_silver/src/utils/constants.dart';
import 'package:localization/localization.dart';

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
            onTap: () => Navigator.pushNamed(context, Routes.changePassword),
            leading: const Icon(Icons.lock),
            title: Text('doi_mat_khau'.i18n()),
          ),
          const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.notifications_active),
          //   title: Text('cai_dat_thong_bao'.i18n()),
          // ),
          // const Divider(),
          // DropdownButton<Locale>(
          //   value: context.read<LocaleBloc>().state.locale,
          //   items: const [
          //     DropdownMenuItem(
          //       value: Locale('vi'),
          //       child: Text('Tiếng Việt'),
          //     ),
          //     DropdownMenuItem(
          //       value: Locale('en'),
          //       child: Text('English'),
          //     ),
          //   ],
          //   onChanged: (locale) {
          //     if (locale != null) {
          //       context.read<LocaleBloc>().add(ChangeLocaleEvent(locale: locale));
          //     }
          //   },
          // ),
          // const Divider(),
          ListTile(
            onTap: () => context.read<AuthBloc>().add(const SignOutEvent()),
            leading: const Icon(Icons.login),
            title: Text('logout'.i18n()),
          ),
        ],
      ),
    );
  }
}
