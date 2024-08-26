import 'dart:developer';

import 'package:auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // Update user preferences
  static Future<void> updateUserPreferences(User user) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    log('Detail Saved');
    await instance.setString('id', user.id.toString());
    await instance.setString('name', user.name.toString());
  }

  static Future<User?> getUserPreferences() async {
    // Get user preferences
    SharedPreferences instance = await SharedPreferences.getInstance();

    String? id = instance.getString('id');
    String? name = instance.getString('name');

    if (id != null && name != null) {
      return User(id: int.parse(id), name: name);
    }

    return null;
  }
}
