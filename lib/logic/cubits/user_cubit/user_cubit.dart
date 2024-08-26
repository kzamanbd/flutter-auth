import 'package:auth/data/models/user_model.dart';
import 'package:auth/data/repositories/user_repository.dart';
import 'package:auth/logic/cubits/user_cubit/user_state.dart';
import 'package:auth/logic/services/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository = UserRepository();

  UserCubit() : super(UserInitialState()) {
    _initialize();
  }

  void _initialize() async {
    final user = await Preferences.getUserPreferences();
    if (user != null) {
      emit(UserAuthenticatedState(user: UserModel(user: user)));
    } else {
      emit(UserLogoutState());
    }
  }

  void _emitUserState(UserModel userModel) async {
    emit(UserAuthenticatedState(user: userModel));

    await Preferences.updateUserPreferences(userModel.user!);
  }

  Future<void> login({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      final user =
          await _userRepository.login(email: email, password: password);
      _emitUserState(user);
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(UserLoadingState());
    try {
      final user = await _userRepository.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      _emitUserState(user);
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(UserLoadingState());
    try {
      await _userRepository.logout();
      emit(UserLogoutState());
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }
}
