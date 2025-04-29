import 'package:flutter/material.dart';
import 'package:gold_silver/src/core/injector/locator.dart';
import 'package:gold_silver/src/core/services/local_notification.dart';
import 'package:gold_silver/src/my_app.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
  runApp(const MyApp());
}

// Calculate time to 9:00 AM to trigger the task
int _calculateInitialDelayHour() {
  final now = DateTime.now();
  final next8AM = DateTime(now.year, now.month, now.day, 9);
  if (now.isAfter(next8AM)) {
    next8AM.add(const Duration(days: 1));
  }
  return next8AM.difference(now).inHours;
}

int _calculateInitialDelayMinute() {
  final now = DateTime.now();
  final next8AM = DateTime(now.year, now.month, now.day, 9);
  if (now.isAfter(next8AM)) {
    next8AM.add(const Duration(days: 1));
  }
  return next8AM.difference(now).inMinutes % 60;
}
