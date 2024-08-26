import 'package:auth/screens/auth/login_screen.dart';
import 'package:auth/screens/auth/providers/auth_provider.dart';
import 'package:auth/widgets/link_button.dart';
import 'package:auth/widgets/primary_button.dart';
import 'package:auth/widgets/primary_textfield.dart';
import 'package:auth/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: provider.formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: [
            const BigText(text: 'Register'),
            const SizedBox(height: 50),
            PrimaryTextfield(
              controller: provider.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              hintText: 'Enter your Name',
              labelText: 'Name',
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            PrimaryTextfield(
              controller: provider.password,
              hintText: 'Enter your confirm password',
              labelText: 'Confirm Password',
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
            PrimaryButton(
              onPressed: provider.register,
              text: provider.isLoading ? 'Loading...' : 'Register',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                const SizedBox(width: 10),
                LinkButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  text: 'Login',
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
