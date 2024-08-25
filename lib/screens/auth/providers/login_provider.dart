import 'dart:async';
import 'dart:developer';
import 'package:auth/logic/cubits/user_cubit/user_cubit.dart';
import 'package:auth/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginProvider with ChangeNotifier {
  BuildContext context;
  LoginProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = '';
  final email = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  StreamSubscription? _userCubitSubscription;

  void _listenToUserCubit() {
    _userCubitSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((UserState state) {
      log("State Listening...");
      if (state is UserLoadingState) {
        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }

      if (state is UserErrorState) {
        error = state.message;
        log("Error: $error");
        notifyListeners();
      }
    });
  }

  void login() async {
    String emailValue = email.text.trim();
    String passwordValue = password.text.trim();

    BlocProvider.of<UserCubit>(context).login(
      email: emailValue,
      password: passwordValue,
    );
  }

  @override
  void dispose() {
    _userCubitSubscription?.cancel();
    super.dispose();
  }
}
