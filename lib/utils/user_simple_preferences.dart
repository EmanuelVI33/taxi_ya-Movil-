import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreference {
  static SharedPreferences? _preferences;

  static const _keyUserId = 'userId';
  static const _keyUserEmail = 'email';
  static const _keyUserPhone = 'phone';
  static const _keyUserToken = 'token';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  // User Id
  static Future setUserId(int userId) async =>
      await _preferences?.setInt(_keyUserId, userId);

  static int? getUserId() => _preferences?.getInt(_keyUserId);

  // User Email
  static Future setUserEmail(String userEmail) async =>
      await _preferences?.setString(_keyUserEmail, userEmail);

  static String? getUserEmail() => _preferences?.getString(_keyUserEmail);

  // User Phone
  static Future setPhone(String phone) async =>
      await _preferences?.setString(_keyUserPhone, phone);

  static String? getPhone() => _preferences?.getString(_keyUserPhone);

  // User Token
  static Future setToken(String token) async =>
      await _preferences?.setString(_keyUserToken, token);

  static String? getToken() => _preferences?.getString(_keyUserToken);
}
