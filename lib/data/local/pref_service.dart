import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static const String _keyUser = 'current_user';

  static Future<void> saveUser(String email) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_keyUser, email);
  }

  static Future<String?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_keyUser);
  }

  static Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
