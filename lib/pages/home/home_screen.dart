import 'package:auth/data/models/user_model.dart';
import 'package:auth/pages/auth/auth_notifier.dart';
import 'package:auth/pages/splash/splash_screen.dart';
import 'package:auth/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = 'home';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.watch(authNotifierProvider);

    ref.listen<AsyncValue<UserModel?>>(userProvider, (previous, next) {
      if (next.value == null && !next.isLoading && !next.hasError) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(context, SplashScreen.routeName);
      }
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed function here
          },
          child: const Icon(Icons.add),
        ),
        body: const Center(
          child: Text('Home Screen'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            if (index == 2) {
              authNotifier.logout();
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
