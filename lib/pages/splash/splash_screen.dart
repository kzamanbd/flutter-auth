import 'dart:async';

import 'package:auth/data/models/user_model.dart';
import 'package:auth/pages/auth/login_screen.dart';
import 'package:auth/pages/home/home_screen.dart';
import 'package:auth/providers/user_provider.dart';
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
    final state = ref.read(userProvider);
    if (state.isLoading) return;

    if (state.hasValue) {
      final user = state.value;
      if (user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    } else if (state.hasError) {
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
    ref.listen<AsyncValue<UserModel?>>(userProvider, (previous, next) {
      goToNextScreen();
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
