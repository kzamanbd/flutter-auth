import 'package:auth/logic/cubits/user_cubit/user_cubit.dart';
import 'package:auth/logic/cubits/user_cubit/user_state.dart';
import 'package:auth/screens/auth/providers/auth_provider.dart';
import 'package:auth/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLogoutState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: MaterialApp(
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
                provider.logout();
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
      ),
    );
  }
}
