// ignore_for_file: non_constant_identifier_names, file_names, avoid_print, depend_on_referenced_packages, unused_local_variable

import 'dart:async';
import 'dart:convert';


import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthResult {
  final int code;
  final String token;
  final bool authenticated;

  AuthResult({required this.code, required this.token, required this.authenticated});

  factory AuthResult.fromJson(Map<String, dynamic> json) {
    return AuthResult(
      code: json["code"],
      token: json["result"]["token"] ?? "",  // Lấy token từ result
      authenticated: json["result"]["authenticated"] ?? false, // Tránh lỗi null
    );
  }
}

class AuthRepository{
Future<AuthResult> authenticate(String password, String username) async {
  String apiUrl = "http://localhost:8080/auth/login";

  try {
  
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"password": password, "username": username}),
    );

    Map<String, dynamic> responseData = json.decode(response.body);
    print("responseData.length: ${responseData.length}");
    
    return AuthResult.fromJson(responseData);
  } catch (e) {
    return AuthResult(code: 0, token: "null", authenticated: false);
  }
}

Future<User> giveUserByName(String userName, String token) async {
  String apiUrl = "http://localhost:8080/myparkingapp/users/$userName/name";

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return User.fromJson(responseData["result"]);
    } else {
      Map<String, dynamic> errorData = json.decode(response.body);
      throw Exception("Lỗi API: ${errorData["message"]}");
    }
  } catch (e) {
    print("Lỗi kết nối: $e");
    throw Exception("Lỗi kết nối: $e");
  }
}

Future<String> Register_MPA(User user) async{
    final String apiUrl = 'http://localhost:8080/myparkingapp/users';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        return "200";

      } else {
        Map<String, dynamic> responseData = json.decode(response.body);
        String code = responseData["code"];
        return code;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return "Error";
    }
  }


Future<void> logout() async{
  final String apiUrl = 'http://localhost:8080/auth/logout';
  try{
    final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',

        });
  }
  catch(e){
    print(e);
  }
}
}

