import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isDark() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("is_dark") ?? false;
}

Future<void> setTheme(bool isDark) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("is_dark", !isDark);
}


Future<int> getPrimaryColorTheme() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt("primary_color") ?? 0xff017e7f;
}

Future<void> setPrimaryColorTheme(int color) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("primary_color", color);
}

Future<double> getFontSize() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble("font_size") ?? 1.0;
}

Future<void> setFontSize(double fontSize) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble("font_size", fontSize);
}





