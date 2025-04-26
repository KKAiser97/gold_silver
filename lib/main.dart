import 'package:flutter/material.dart';
import 'package:gold_silver/src/core/injector/locator.dart';
import 'package:gold_silver/src/my_app.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}
