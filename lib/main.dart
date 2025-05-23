import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gold_silver/src/core/client/dio_client.dart';
import 'package:gold_silver/src/core/injector/locator.dart';
import 'package:gold_silver/src/core/services/local_notification.dart';
import 'package:gold_silver/src/my_app.dart';
import 'package:gold_silver/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Initialize the locator
  setupLocator();

  /// Set up schedule service
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    "1",
    fetchMetalPriceTask,
    frequency: const Duration(hours: 24),
    initialDelay: Duration(
      hours: _calculateInitialDelayHour(),
      minutes: _calculateInitialDelayMinute(),
    ),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
  final xchangeRateDio = ExchangeRateDioClient().dio;
  await Future.wait([
    Firebase.initializeApp(),
    checkFirstLaunchAndFetchData(xchangeRateDio),
  ]);
  runApp(const MyApp());
}

// Calculate time to 9:00 AM to trigger the task
int _calculateInitialDelayHour() {
  final now = DateTime.now();
  final next9AM = DateTime(now.year, now.month, now.day, 9);
  if (now.isAfter(next9AM)) {
    next9AM.add(const Duration(days: 1));
  }
  return next9AM.difference(now).inHours;
}

int _calculateInitialDelayMinute() {
  final now = DateTime.now();
  final next9AM = DateTime(now.year, now.month, now.day, 9);
  if (now.isAfter(next9AM)) {
    next9AM.add(const Duration(days: 1));
  }
  return next9AM.difference(now).inMinutes % 60;
}

Future<void> checkFirstLaunchAndFetchData(Dio dio) async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool(SharedKey.firstRun) ?? true;

  if (isFirstLaunch) {
    await getExchangeRate(dio);
    await prefs.setBool(SharedKey.firstRun, false);
  }
}
