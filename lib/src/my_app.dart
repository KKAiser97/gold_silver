import 'package:flutter/material.dart';
import 'package:gold_silver/src/features/main/main_page.dart';
import 'package:gold_silver/src/theme/app_color.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gold Silver Alert',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.schemeColor),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}