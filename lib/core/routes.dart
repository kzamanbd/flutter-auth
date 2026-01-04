import 'package:auth/pages/auth/login_screen.dart';
import 'package:auth/pages/auth/not_found_screen.dart';
import 'package:auth/pages/auth/register_screen.dart';
import 'package:auth/pages/home/home_screen.dart';
import 'package:auth/pages/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case HomeScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case LoginScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      case RegisterScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const RegisterScreen());

      default:
        return CupertinoPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
