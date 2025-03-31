import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/user__response.dart';

class UserRepository{

  Future<ApiResult> getUserByUserName(String userName) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.getUserByUserName(userName);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['mess'];
      UserResponse user = UserResponse.fromJson(jsonData['result']);

      // Chuyển 'result' từ JSON thành danh sách Discount
      

      return ApiResult(code, mess, user);
    } else {
      throw Exception("UserRepository_getUserByUserName");
    }
  } catch (e) {
    throw Exception("UserRepository_getUserByUserName: $e");
  }

  }

  Future<ApiResult> updateUser(UpdateUserRequest user) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.updateUser(user);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['mess'];
      return ApiResult(code, mess, user);
    } else {
      throw Exception("UserRepository_updateUser");
    }
  } catch (e) {
    throw Exception("UserRepository_updateUser: $e");
  }

  }
  Future<ApiResult> changePass(String userID, String oldPass, String newPass) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.changePassWord(userID, oldPass, newPass);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['mess'];
      return ApiResult(code, mess, '');
    } else {
      throw Exception("UserRepository_changePass");
    }
  } catch (e) {
    throw Exception("UserRepository_changePass: $e");
  }

  }






}
