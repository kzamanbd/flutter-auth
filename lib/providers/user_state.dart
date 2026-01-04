import 'package:auth/data/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserAuthenticatedState extends UserState {
  final UserModel user;

  UserAuthenticatedState({required this.user});
}

class UserLogoutState extends UserState {}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});
}
