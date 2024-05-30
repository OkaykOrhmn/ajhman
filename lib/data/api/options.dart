import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:dio/dio.dart';

Future<Options> getDioOptions() async{
  final token = await getToken();
  return Options(headers: {
    "Content-Type": "application/json",
    'accept': '*/*',
    'Authorization': "Bearer $token",
  });
}
