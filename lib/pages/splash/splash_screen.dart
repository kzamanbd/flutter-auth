import 'dart:async';

import 'package:auth/providers/user_provider.dart';
import 'package:auth/providers/user_state.dart';
import 'package:auth/pages/auth/login_screen.dart';
import 'package:auth/pages/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const routeName = 'splash';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  void goToNextScreen() {
    // user is authenticated
    UserState state = ref.read(userProvider);
    if (state is UserAuthenticatedState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else if (state is UserLogoutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(microseconds: 100), () {
      goToNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserState>(userProvider, (previous, next) {
      goToNextScreen();
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
