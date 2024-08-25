import 'package:auth/data/repositories/user_repository.dart';
import 'package:auth/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository = UserRepository();

  UserCubit() : super(UserInitialState());

  Future<void> login({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      final user =
          await _userRepository.login(email: email, password: password);
      emit(UserAuthenticatedState(user: user));
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
      emit(UserAuthenticatedState(user: user));
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
