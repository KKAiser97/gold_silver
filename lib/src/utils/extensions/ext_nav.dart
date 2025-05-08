import 'package:flutter/material.dart';

extension NavigatorStateX on NavigatorState {
  String? get currentRouteName {
    String? name;
    popUntil((route) {
      name = route.settings.name;
      return true;
    });
    return name;
  }
}
