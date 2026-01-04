import 'package:auth/data/models/user_model.dart';
import 'package:auth/data/repositories/user_repository.dart';
import 'package:auth/providers/user_state.dart';
import 'package:auth/services/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends Notifier<UserState> {
  final UserRepository _userRepository = UserRepository();

  @override
  UserState build() {
    _initialize();
    return UserInitialState();
  }

  void _initialize() async {
    final user = await Preferences.getUserPreferences();
    if (user != null) {
      state = UserAuthenticatedState(user: UserModel(user: user));
    } else {
      state = UserLogoutState();
    }
  }

  void _emitUserState(UserModel userModel) async {
    state = UserAuthenticatedState(user: userModel);
    await Preferences.updateUserPreferences(userModel.user!);
  }

  Future<void> login({required String email, required String password}) async {
    state = UserLoadingState();
    try {
      final user =
          await _userRepository.login(email: email, password: password);
      _emitUserState(user);
    } catch (e) {
      state = UserErrorState(message: e.toString());
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    state = UserLoadingState();
    try {
      final user = await _userRepository.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      _emitUserState(user);
    } catch (e) {
      state = UserErrorState(message: e.toString());
    }
  }

  Future<void> logout() async {
    state = UserLoadingState();
    try {
      state = UserLogoutState();
      await Preferences.clearUserPreferences();
    } catch (e) {
      state = UserErrorState(message: e.toString());
    }
  }
}

final userProvider =
    NotifierProvider<UserNotifier, UserState>(UserNotifier.new);
