import 'package:auth/core/theme.dart';
import 'package:auth/screens/auth/providers/login_provider.dart';
import 'package:auth/widgets/link_button.dart';
import 'package:auth/widgets/primary_button.dart';
import 'package:auth/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';
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
    return Builder(builder: (context) {
      final provider = Provider.of<LoginProvider>(context);
      return Scaffold(
          body: SafeArea(
        child: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              const Text(
                'Login',
                style: TextStyles.h1,
              ),
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
                      Navigator.pushNamed(context, 'register');
                    },
                    text: 'Register',
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    });
  }
}
