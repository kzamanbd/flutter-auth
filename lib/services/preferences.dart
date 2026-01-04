import 'package:auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<void> saveUserModel(UserModel userModel) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    if (userModel.user?.id != null) {
      await instance.setString('id', userModel.user!.id.toString());
    }
    if (userModel.user?.name != null) {
      await instance.setString('name', userModel.user!.name!);
    }
    if (userModel.token != null) {
      await instance.setString('token', userModel.token!);
    }
  }

  static Future<UserModel?> getUserModel() async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    String? id = instance.getString('id');
    String? name = instance.getString('name');
    String? token = instance.getString('token');

    if (token != null) {
      return UserModel(
        user: User(
          id: id != null ? int.tryParse(id) : null,
          name: name,
        ),
        token: token,
      );
    }

    return null;
  }

  static Future<void> clearUserPreferences() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.clear();
  }
}
