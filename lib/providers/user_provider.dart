import 'package:auth/data/models/user_model.dart';
import 'package:auth/data/repositories/user_repository.dart';
import 'package:auth/services/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends AsyncNotifier<UserModel?> {
  final UserRepository _userRepository = UserRepository();

  @override
  Future<UserModel?> build() async {
    return _initialize();
  }

  Future<UserModel?> _initialize() async {
    return await Preferences.getUserModel();
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user =
          await _userRepository.login(email: email, password: password);
      await Preferences.saveUserModel(user);
      return user;
    });
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _userRepository.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      await Preferences.saveUserModel(user);
      return user;
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Preferences.clearUserPreferences();
      return null;
    });
  }
}

final userProvider =
    AsyncNotifierProvider<UserNotifier, UserModel?>(UserNotifier.new);
