// ignore_for_file: avoid_print, non_constant_identifier_names, file_names, unused_local_variable

import 'dart:async';
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_owner_request.dart';
import 'package:myparkingappadmin/data/dto/request/update_user_request.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';



class UserRepository {
  Future<ApiResult> getAllOwnerUser() async {
    try {

      ApiClient apiClient = ApiClient();
      final response = await apiClient.getAllUser();
      int code = response.data["code"];
      String mess = response.data["mess"];
      if(response.statusCode == 200){
        List<UserResponse> users = (response.data["result"] as List)
            .map((item) => UserResponse.fromJson(item))
            .toList();
        List<UserResponse> ownerUsers = users.where((e)=>e.roles.contains("PARKING_OWNER")).toList();

        ApiResult apiResult = ApiResult(
           code, mess, users
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
      throw Exception("UserRepository_getAllOwnerUser: $e");
    }
  }
  Future<ApiResult> getAllCustomerUser() async {
    try {

      ApiClient apiClient = ApiClient();
      final response = await apiClient.getAllUser();
      int code = response.data["code"];
      String mess = response.data["mess"];
      if(response.statusCode == 200){
        List<UserResponse> users = (response.data["result"] as List)
            .map((item) => UserResponse.fromJson(item))
            .toList();
        List<UserResponse> customerUsers = users.where((e)=>e.roles.contains("USER")).toList();
        ApiResult apiResult = ApiResult(
           code, mess, customerUsers
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
      throw Exception("UserRepository_getAllCustomerUser: $e");
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
  Future<ApiResult> updatedStatusUser(String userId,  UserStatus newStatus) async{
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.updateStatusUser(newStatus, userId);
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
      throw Exception("UserRepository_updatedStatusUser:  $e");
    }

  }
  Future<ApiResult> register(CreateParkingOwnerRequest request) async{
    try {
      ApiClient apiClient = ApiClient();
      print("client app : ${request.toString()}");
      final response = await apiClient.register(request);
      int code = response.data["code"];
      String mess = response.data["message"];
        ApiResult apiResult = ApiResult(
           code, mess, null
        );
        return apiResult; 
    }
    catch(e){
      throw Exception("UserRepository_register:  $e");
    }

  }
  Future<ApiResult> getMe() async{
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getMe();
      int code = response.data["code"];
      String mess = response.data["message"];
      UserResponse userResponse = UserResponse.fromJson(response.data["result"]);
      if(response.statusCode == 200){
        ApiResult apiResult = ApiResult(
           code, mess, userResponse
        );
        return apiResult;
      }
      else{
        ApiResult apiResult = ApiResult(
           code, mess, userResponse
        );
        return apiResult;
      }      
    }
    catch(e){
      throw Exception("UserRepository_register:  $e");
    }

  }
  Future<ApiResult> changePassWord(String userId, String oldPass, String newPass) async{
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.changePassWord(userId, oldPass, newPass);
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
      throw Exception("UserRepository_register:  $e");
    }

  }
}