import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_state.dart';
import 'package:gold_silver/src/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoaded) {
            Navigator.pushReplacementNamed(context, Routes.main);
          } else if (state is AuthError || state is AuthInitial) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        },
        child: const Center(child: CircularProgressIndicator()), //TODO: add splash img
      ),
    );
    // return FutureBuilder(
    //   future: Future.delayed(const Duration(seconds: 1), () => FirebaseAuth.instance.currentUser),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     } else {
    //       final user = snapshot.data;
    //       if (user != null) {
    //
    //         return const MainScreen();
    //       } else {
    //         return const LoginScreen();
    //       }
    //     }
    //   },
    // );
  }
}
