import 'package:auth/core/api.dart';
import 'package:auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final _api = Api();
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      Response response = await _api.request.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // convert json to model
      return UserModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.request.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // convert json to model
      return UserModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }
}
