import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const Center(
          child: Text('Home Screen'),
        ),
      ),
    );
  }
}
