import 'package:auth/data/models/user_model.dart';
import 'package:auth/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends ChangeNotifier {
  final Ref ref;

  AuthNotifier(this.ref);

  bool isLoading = false;
  String error = '';
  final name = TextEditingController(text: 'Kzaman');
  final email = TextEditingController(text: 'kzamanbn@gmail.com');
  final password = TextEditingController(text: 'password');
  final passwordConfirmation = TextEditingController(text: 'password');

  final formKey = GlobalKey<FormState>();

  void updateState(AsyncValue<UserModel?> state) {
    if (state.isLoading) {
      isLoading = true;
    } else if (state.hasError) {
      isLoading = false;
      error = state.error.toString();
    } else {
      error = '';
      isLoading = false;
    }
    notifyListeners();
  }

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    String emailValue = email.text.trim();
    String passwordValue = password.text.trim();

    await ref.read(userProvider.notifier).login(
          email: emailValue,
          password: passwordValue,
        );
  }

  void register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    String nameValue = name.text.trim();
    String emailValue = email.text.trim();
    String passwordValue = password.text.trim();
    String passwordConfirmationValue = passwordConfirmation.text.trim();

    await ref.read(userProvider.notifier).register(
          name: nameValue,
          email: emailValue,
          password: passwordValue,
          passwordConfirmation: passwordConfirmationValue,
        );
  }

  void logout() {
    ref.read(userProvider.notifier).logout();
  }
}

final authNotifierProvider =
    ChangeNotifierProvider.autoDispose<AuthNotifier>((ref) {
  final notifier = AuthNotifier(ref);
  ref.listen<AsyncValue<UserModel?>>(userProvider, (previous, next) {
    notifier.updateState(next);
  });
  return notifier;
});
