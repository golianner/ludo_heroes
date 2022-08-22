import 'package:flutter/material.dart';
import 'package:ludo_heroes/src/presentation/screens/default_screen/default_screen.dart';
import 'package:ludo_heroes/src/presentation/screens/main_screen/main_screen.dart';
import 'package:ludo_heroes/src/presentation/screens/map_screens/map_default_screen.dart';
import 'package:ludo_heroes/src/presentation/screens/splash_screen/splash_screen.dart';
import 'package:ludo_heroes/src/utils/const/routes_const.dart';

class Routes {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConst.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case RoutesConst.mainScreen:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
      case RoutesConst.mapDefaultScreen:
        return MaterialPageRoute(
          builder: (_) => const MapDefaultScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const DefaultScreen(),
        );
    }
  }
}
