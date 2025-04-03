// ignore_for_file: file_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_owner_request.dart';
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';

class AuthRepository {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<ApiResult> login(String username, String password) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.login(username, password);
      if (response.statusCode == 200) {
        String accessToken = response.data['result']['access_token'];
        String refreshToken = response.data['result']['refresh_token'];
        bool isAuth = response.data['result']["authentication"];
        ApiResult apiResult = ApiResult(response.data['code'], response.data['mess'], isAuth);
        await storage.write(key: 'access_token', value: accessToken);
        await storage.write(key: 'refresh_token', value: refreshToken);
        return apiResult;
      }
      else{
        throw Exception("_AuthRepository:");
      }
    } catch (e) {
      throw Exception("_AuthRepository: $e");
    }
  }

  Future<ApiResult> register(CreateParkingOwnerRequest user) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.register(user);
      if (response.statusCode == 200) {
        ApiResult apiResult = ApiResult(response.data['code'], response.data['mess'],'');
        return apiResult;
      }
      else{
        throw Exception("_AuthRepository_register:");
      }
    } catch (e) {
      throw Exception("_AuthRepository_register: $e");
    }
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<void> refreshAccessToken() async {
    try {
      ApiClient apiClient = ApiClient();
      String? refreshToken = await storage.read(key: 'refresh_token');
      if (refreshToken == null) return;

      final response = await apiClient.refreshToken(refreshToken);
      if (response.statusCode == 200) {
        String newAccessToken = response.data['access_token'];
        await storage.write(key: 'access_token', value: newAccessToken);
      }
    } catch (e) {
      Exception("Token refresh failed: $e");
    
    }
  }

  Future<ApiResult> giveEmail(String email) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.giveEmail(email);
      if (response.statusCode == 200) {
        ApiResult apiResult = ApiResult(response.data['code'], response.data['mess'],response.data['result']['token']);
        return apiResult;
      }
      else{
        throw Exception("_AuthRepository_giveEmail:");
      }
    } catch (e) {
      throw Exception("_AuthRepository_giveEmail: $e");
    }
  }

    Future<ApiResult> giveRePassWord(String newPass, String token) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.giveRePassWord(newPass, token);
      if (response.statusCode == 200) {
        ApiResult apiResult = ApiResult(response.data['code'], response.data['mess'],'');
        return apiResult;
      }
      else{
        throw Exception("_AuthRepository_giveEmail:");
      }
    } catch (e) {
      throw Exception("_AuthRepository_giveEmail: $e");
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }
}
