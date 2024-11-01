import 'package:flutter/material.dart';

import '../presentation/screens/home_screen.dart';

class RoutesManager {
  static const homeRoute = '/home';

  static Route<dynamic>? router(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        {
          return MaterialPageRoute(
            builder: (context) => HomeScreen(),
          );
        }
    }
  }
}
