// ignore_for_file: avoid_print, non_constant_identifier_names, file_names, unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:myparkingappadmin/data/dto/request/update_user_request.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';
import 'package:http/http.dart' as http;

class UserByPage{
  List<UserResponse> users;
  int page;
  int pageTotal;
  UserByPage(this.users,this.page,this.pageTotal);

    // Chuyển từ JSON sang UserByPage
  factory UserByPage.fromJson(Map<String, dynamic> json) {
    return UserByPage(
      (json['users'] as List<dynamic>)
          .map((user) => UserResponse.fromJson(user))
          .toList(),
      json['page'] as int,
      json['pageTotal'] as int,
    );
  }
}

class UserRepository {
  Future<ApiResult> giveAllUserByPage_BySearch_By(int page, String searchText) async {
    try {

      ApiClient apiClient = ApiClient();
      print("user $searchText");
      String searchKey = searchText.toLowerCase().trim();
      final response = await apiClient.getAllUserByUser(searchText, page);
      int code = response.data["code"];
      String mess = response.data["mess"];
      if(response.statusCode == 200){
        UserByPage userByPage = UserByPage.fromJson(response.data["result"]);
        ApiResult apiResult = ApiResult(
           code, mess, userByPage
        );
        return apiResult;
      }
      else{
        ApiResult apiResult = ApiResult(
           code, mess, null
        );
        return apiResult;
      }      
    } catch (e) {
      throw Exception("UserRepository_giveAllUserByPage_BySearch_By: $e");
    }
  }
  Future<ApiResult> updatedUser(UpdateInfoResquest user, String userId) async{
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.updateUser(user, userId);
      int code = response.data["code"];
      String mess = response.data["mess"];
      if(response.statusCode == 200){
        ApiResult apiResult = ApiResult(
           code, mess, null
        );
        return apiResult;
      }
      else{
        ApiResult apiResult = ApiResult(
           code, mess, null
        );
        return apiResult;
      }      


    }
    catch(e){
      throw Exception("UserRepository_updatedUser:  $e");
    }
  }
  Future<ApiResult> updatedStatusUser(UserResponse user,  String newStatus) async{
    try {
    }
    catch(e){
      throw Exception("UserRepository_updatedStatusUser:  $e");
    }

  }
}