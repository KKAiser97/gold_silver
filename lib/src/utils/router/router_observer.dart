import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gold_silver/src/utils/router/app_router.dart';

class RouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppRouter.unFocus();
    super.didPush(route, previousRoute);
    AppRouter.routes.add(route.settings.name);
    log(
      '${previousRoute?.settings.name} ==> [Current route: "${route.settings.name}"]',
      name: 'PUSH',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppRouter.unFocus();
    super.didPop(route, previousRoute);
    AppRouter.routes.remove(route.settings.name);
    log(
      '[Current route: "${previousRoute?.settings.name}"] <== ${route.settings.name}',
      name: 'POP',
    );
  }
}
