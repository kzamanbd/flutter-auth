import 'package:auth/logic/cubits/user_cubit/user_cubit.dart';
import 'package:auth/logic/cubits/user_cubit/user_state.dart';
import 'package:auth/screens/auth/providers/auth_provider.dart';
import 'package:auth/screens/auth/register_screen.dart';
import 'package:auth/screens/home/home_screen.dart';
import 'package:auth/widgets/link_button.dart';
import 'package:auth/widgets/primary_button.dart';
import 'package:auth/widgets/primary_textfield.dart';
import 'package:auth/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserAuthenticatedState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      child: Scaffold(
          body: SafeArea(
        child: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              const BigText(text: 'Login'),
              const SizedBox(height: 50),
              PrimaryTextfield(
                controller: provider.email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                hintText: 'Enter your email',
                labelText: 'Email',
              ),
              const SizedBox(height: 20),
              PrimaryTextfield(
                controller: provider.password,
                hintText: 'Enter your password',
                labelText: 'Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                obscureText: true,
              ),
              if (provider.error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    provider.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'forgot-password');
                    },
                    text: 'Forgot your password?',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onPressed: provider.login,
                text: provider.isLoading ? 'Loading...' : 'Login',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  const SizedBox(width: 10),
                  LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    text: 'Register',
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
