import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/core/injector/locator.dart';
import 'package:gold_silver/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:gold_silver/src/features/authentication/presentation/screens/register_screen.dart';
import 'package:gold_silver/src/features/authentication/presentation/screens/splash_screen.dart';
import 'package:gold_silver/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/bloc/password_bloc.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/forgot_password_screen.dart';
import 'package:gold_silver/src/features/main/main_screen.dart';
import 'package:gold_silver/src/utils/constants.dart';
import 'package:gold_silver/src/utils/extensions/exts.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final List<String?> routes = [];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PasswordBloc>(
            create: (_) => locator<PasswordBloc>(),
            child: const ForgotPasswordScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }

  static void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(AppRouter.context!).unfocus();
  }

  static NavigatorState get state => navigatorKey.currentState!;

  static BuildContext? get context => navigatorKey.currentContext;

  static String? get currentRoute => navigatorKey.currentState?.currentRouteName;

  static bool get canPop => state.canPop();
}
