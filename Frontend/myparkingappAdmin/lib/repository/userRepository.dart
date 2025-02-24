// ignore_for_file: avoid_print, non_constant_identifier_names, file_names, unused_local_variable

import 'dart:async';
import 'dart:convert';

import '../apiResponse.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  // api version
  // Future<APIResult> GiveAllUserByPage_BySearch_ByOWNER_ROLE(int page, String token, String ROLE, String searchText) async {
  //   String apiURL = "http://localhost:8080/myparkingapp/users/$page/$ROLE";
  //   try {
  //     final response = await http.get(
  //       Uri.parse(apiURL),
  //       headers: {
  //         "Content-Type": "application/json",
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> responseData = json.decode(response.body);
  //       int code = responseData["code"];
  //       String message = responseData["message"];
  //
  //       List<dynamic> contentList = responseData["result"]["content"];
  //       int pageAmount = responseData["result"]["content"]["amount"];
  //       List<User> customers = contentList.map((userJson) =>
  //           User.fromJson(userJson)).toList();
  //       return APIResult(code: code, message: message, result: customers,pageAmount);
  //     } else {
  //       throw Exception("Lỗi server: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     throw Exception("Lỗi kết nối: $e");
  //   }
  // }
  // Future<APIResult> GiveAllUserByPage_BySearch_ByCUSTOMER_ROLE(int page, String token, String ROLE, String searchText) async {
  //   String apiURL = "http://localhost:8080/myparkingapp/users/$page/$ROLE";
  //   try {
  //     final response = await http.get(
  //       Uri.parse(apiURL),
  //       headers: {
  //         "Content-Type": "application/json",
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> responseData = json.decode(response.body);
  //       int code = responseData["code"];
  //       String message = responseData["message"];
  //
  //       List<dynamic> contentList = responseData["result"]["content"];
  //       int pageAmount = responseData["result"]["content"]["amount"];
  //       List<User> customers = contentList.map((userJson) =>
  //           User.fromJson(userJson)).toList();
  //       return APIResult(code: code, message: message, result: customers, pageAmount);
  //     } else {
  //       throw Exception("Lỗi server: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     throw Exception("Lỗi kết nối: $e");
  //   }
  // }
  // Future<APIResult> updatedUser(User user, String token) async{
  //   final String apiUrl = 'http://localhost:8080/smartwalletapp/users/${user.userId}';
  //
  //   try {
  //     print("user $user");
  //     final response = await http.put(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode(user.toJson()),
  //     );
  //
  //     Map<String, dynamic> responseData = json.decode(response.body);
  //     int code = responseData["code"];
  //     String message = responseData["message"];
  //
  //     if(response.statusCode == 200){
  //       User user = User.fromJson(responseData["result"]);
  //       APIResult apiResult= APIResult(0, code: code, message: message, result: user);
  //       return apiResult;
  //     }
  //     else {
  //       APIResult apiResult= APIResult(0, code: code, message: message, result: "null");
  //       return apiResult;
  //     }
  //   }
  //   catch(e){
  //     throw Exception("updatedUser_repo:  $e");
  //   }
  // }
  // Future<APIResult> updatedStatusUser(User user, String token, String newStatus) async{
  //   final String apiUrl = 'http://localhost:8080/smartwalletapp/users/${user.userId}';
  //
  //   try {
  //     print("user $user");
  //     final response = await http.put(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode({"newStatus": newStatus,}),
  //     );
  //
  //     Map<String, dynamic> responseData = json.decode(response.body);
  //     int code = responseData["code"];
  //     String message = responseData["message"];
  //
  //     if(response.statusCode == 200){
  //       User user = User.fromJson(responseData["result"]);
  //       APIResult apiResult= APIResult(0, code: code, message: message, result: user);
  //       return apiResult;
  //     }
  //     else {
  //       APIResult apiResult= APIResult(0, code: code, message: message, result: "null");
  //       return apiResult;
  //     }
  //   }
  //   catch(e){
  //     throw Exception("updatedUser_repo:  $e");
  //   }
  //
  // }
  // mockup version
  Future<APIResult> giveAllUserByPage_BySearch_ByOWNER_ROLE(int page, String token, String ROLE, String searchText) async {
    try {
      print("user ${searchText}");
      String searchKey = searchText.toLowerCase().trim();
      List<User> user = demoCustomersList.where((user) =>
      user.roles.contains("OWNER") && // Sửa lỗi "ONWER" thành "OWNER"
          (searchKey.isEmpty || user.firstName.toLowerCase().contains(searchKey)) // Nếu searchKey rỗng, không lọc theo tên
      ).toList();
      print("user ${user.length}");
      APIResult apiResult = APIResult(1, code: 200, message: "", result: user);
      return apiResult;
    } catch (e) {
      throw Exception("Lỗi kết nối: $e");
    }
  }
  Future<APIResult> giveAllUserByPage_BySearch_ByCUSTOMER_ROLE(int page, String token, String ROLE, String searchText) async {
    String apiURL = "http://localhost:8080/myparkingapp/users/$page/$ROLE";
    try {
      try {
        String searchKey = searchText.toLowerCase().trim();
        List<User> user = demoCustomersList.where((user) =>
        user.roles.contains("CUSTOMER") && // Sửa lỗi "ONWER" thành "OWNER"
            (searchKey.isEmpty || user.firstName.toLowerCase().contains(searchKey)) // Nếu searchKey rỗng, không lọc theo tên
        ).toList();
        APIResult apiResult = APIResult(1, code: 200, message: "", result: user);
        return apiResult;
      } catch (e) {
        throw Exception("Lỗi kết nối: $e");
      }
    } catch (e) {
      throw Exception("Lỗi kết nối: $e");
    }
  }
  Future<APIResult> updatedUser(User user, String token) async{
    final String apiUrl = 'http://localhost:8080/smartwalletapp/users/${user.userId}';

    try {
      print("user $user");
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(user.toJson()),
      );

      Map<String, dynamic> responseData = json.decode(response.body);
      int code = responseData["code"];
      String message = responseData["message"];

      if(response.statusCode == 200){
        User user = User.fromJson(responseData["result"]);
        APIResult apiResult= APIResult(0, code: code, message: message, result: user);
        return apiResult;
      }
      else {
        APIResult apiResult= APIResult(0, code: code, message: message, result: "null");
        return apiResult;
      }
    }
    catch(e){
      throw Exception("updatedUser_repo:  $e");
    }
  }
  Future<APIResult> updatedStatusUser(User user, String token, String newStatus) async{
    final String apiUrl = 'http://localhost:8080/smartwalletapp/users/${user.userId}';

    try {
      print("user $user");
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"newStatus": newStatus,}),
      );

      Map<String, dynamic> responseData = json.decode(response.body);
      int code = responseData["code"];
      String message = responseData["message"];

      if(response.statusCode == 200){
        User user = User.fromJson(responseData["result"]);
        APIResult apiResult= APIResult(0, code: code, message: message, result: user);
        return apiResult;
      }
      else {
        APIResult apiResult= APIResult(0, code: code, message: message, result: "null");
        return apiResult;
      }
    }
    catch(e){
      throw Exception("updatedUser_repo:  $e");
    }

  }
}