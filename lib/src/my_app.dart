import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/splash_screen.dart';
import 'package:gold_silver/src/theme/app_color.dart';

import 'core/injector/locator.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/bloc/auth_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => locator<AuthBloc>()..add(const CheckUserEvent()),
      child: MaterialApp(
        title: 'Gold Silver Alert',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.schemeColor),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
