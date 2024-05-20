
import 'package:flutter/material.dart';

import '../../features/home/presentation/pages/home_screen.dart';

class AppRoutes{

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const HomeScreen());
      default:
        return _materialRoute(const HomeScreen());
    }
  }


  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}