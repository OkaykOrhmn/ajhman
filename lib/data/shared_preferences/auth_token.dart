import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("auth_token") ?? "";
}

Future<void> setToken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("auth_token", token);
}

Future<void> clearToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('auth_token');
}
