import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/response/user.dart';

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
      User user = User.fromJson(jsonData['result']);

      // Chuyển 'result' từ JSON thành danh sách Discount
      

      return ApiResult(code, mess, user);
    } else {
      throw Exception("UserRepository_getUserByUserName");
    }
  } catch (e) {
    throw Exception("UserRepository_getUserByUserName: $e");
  }

  }

  Future<ApiResult> updateUser(User user) async{
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






}
