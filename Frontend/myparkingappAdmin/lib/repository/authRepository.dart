// ignore_for_file: file_names, deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_owner_request.dart';
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';

class AuthRepository {
  // Lưu token vào sessionStorage
  void saveToken(String key, String value) {
    html.window.sessionStorage[key] = value;
  }

  // Lấy token từ sessionStorage
  String? getToken(String key) {
    return html.window.sessionStorage[key];
  }

  // Xóa token
  void clearToken(String key) {
    html.window.sessionStorage.remove(key);
  }

  // Xóa toàn bộ session
  void clearSession() {
    html.window.sessionStorage.clear();
  }

  // Hàm đăng nhập
  Future<ApiResult> login(String username, String password) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.login(username, password);
      print(response.data);

      if (response.statusCode == 200) {
        String accessToken = response.data['result']['accessToken'];
        String refreshToken = response.data['result']['refreshToken'];
        bool isAuth = response.data['result']['authenticated'] ?? false; 

        // Lưu token vào sessionStorage
        saveToken('access_token', accessToken);
        saveToken('refresh_token', refreshToken);

        return ApiResult(
          response.data['code'],
          isAuth.toString() ,
          isAuth,
        );
      } else {
        throw Exception("_AuthRepository: login failed");
      }
    } catch (e) {
      throw Exception("_AuthRepository: $e");
    }
  }

  // Hàm đăng ký
  Future<ApiResult> register(CreateParkingOwnerRequest user) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.register(user);
      if (response.statusCode == 200) {
        return ApiResult(response.data['code'], response.data['mess'], '');
      } else {
        throw Exception("_AuthRepository_register:");
      }
    } catch (e) {
      throw Exception("_AuthRepository_register: $e");
    }
  }

  // Hàm làm mới access token
  Future<void> refreshAccessToken() async {
    try {
      ApiClient apiClient = ApiClient();
      String? refreshToken = getToken('refresh_token');
      if (refreshToken == null) return;

      final response = await apiClient.refreshToken(refreshToken);
      if (response.statusCode == 200) {
        String newAccessToken = response.data['access_token'];
        saveToken('access_token', newAccessToken);
      }
    } catch (e) {
      print("Token refresh failed: $e");
    }
  }

  // Gửi email
  Future<ApiResult> giveEmail(String email) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.giveEmail(email);
      if (response.statusCode == 200) {
        return ApiResult(
          response.data['code'],
          response.data['mess'],
          response.data['result']['token'],
        );
      } else {
        throw Exception("_AuthRepository_giveEmail:");
      }
    } catch (e) {
      throw Exception("_AuthRepository_giveEmail: $e");
    }
  }

  // Cập nhật mật khẩu mới
  Future<ApiResult> giveRePassWord(String newPass, String token) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.giveRePassWord(newPass, token);
      if (response.statusCode == 200) {
        return ApiResult(response.data['code'], response.data['mess'], '');
      } else {
        throw Exception("_AuthRepository_giveRePassWord:");
      }
    } catch (e) {
      throw Exception("_AuthRepository_giveRePassWord: $e");
    }
  }

  // Đăng xuất
  Future<void> logout() async {
    clearSession();
  }
}
