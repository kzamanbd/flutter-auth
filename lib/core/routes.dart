import 'package:auth/screens/auth/login_screen.dart';
import 'package:auth/screens/auth/not_found_screen.dart';
import 'package:auth/screens/auth/providers/auth_provider.dart';
import 'package:auth/screens/auth/register_screen.dart';
import 'package:auth/screens/home/home_screen.dart';
import 'package:auth/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case HomeScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => AuthProvider(context),
                child: const HomeScreen()));
      case LoginScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => AuthProvider(context),
                child: const LoginScreen()));
      case RegisterScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => AuthProvider(context),
                child: const RegisterScreen()));

      default:
        return CupertinoPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
