import 'dart:async';
import 'package:auth/logic/cubits/user_cubit/user_cubit.dart';
import 'package:auth/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterProvider with ChangeNotifier {
  BuildContext context;
  RegisterProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = '';
  final name = TextEditingController(text: 'Zaman');
  final email = TextEditingController(text: 'kzamanbn@gmail.com');
  final password = TextEditingController(text: 'password');
  final passwordConfirmation = TextEditingController(text: 'password');

  final formKey = GlobalKey<FormState>();

  StreamSubscription? _userCubitSubscription;

  void _listenToUserCubit() {
    _userCubitSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((UserState state) {
      if (state is UserLoadingState) {
        isLoading = true;
        notifyListeners();
      } else if (state is UserErrorState) {
        isLoading = false;
        error = state.message;
        notifyListeners();
      } else {
        error = '';
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    String nameValue = name.text.trim();
    String emailValue = email.text.trim();
    String passwordValue = password.text.trim();
    String passwordConfirmationValue = passwordConfirmation.text.trim();

    BlocProvider.of<UserCubit>(context).register(
      name: nameValue,
      email: emailValue,
      password: passwordValue,
      passwordConfirmation: passwordConfirmationValue,
    );
  }

  @override
  void dispose() {
    _userCubitSubscription?.cancel();
    super.dispose();
  }
}
