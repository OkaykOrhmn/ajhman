import 'dart:convert';

import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProfileResponseModel> getProfile() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return ProfileResponseModel.fromJson(
      jsonDecode(prefs.getString("profile_data") ?? ""));
}

Future<void> setProfile(ProfileResponseModel profile) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("profile_data", jsonEncode(profile.toJson()));
}
