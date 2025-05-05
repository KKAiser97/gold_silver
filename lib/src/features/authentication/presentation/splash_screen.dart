import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_state.dart';
import 'package:gold_silver/src/features/authentication/presentation/login_screen.dart';
import 'package:gold_silver/src/features/main/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoaded) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          } else if (state is AuthError || state is AuthInitial) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
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
