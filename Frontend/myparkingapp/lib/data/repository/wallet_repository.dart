

import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/response/user__response.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/response/wallet__response.dart';


class WalletRepository{
  Future<ApiResult> getWalletByUser(UserResponse user) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.getWalletByUser(user.userID);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['mess'];

      // Chuyển 'result' từ JSON thành danh sách Discount
      List<WalletResponse> wallets = (jsonData['result'] as List)
          .map((json) => WalletResponse.fromJson(json))
          .toList();
      return ApiResult(code, mess, wallets);
    } else {
      throw Exception("WalletRepository_getWalletByUser");
    }
  } catch (e) {
    throw Exception("WalletRepository_getWalletByUser: $e");
  }

  }
  Future<ApiResult> createWallet(WalletResponse wallet) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.createWallet(wallet);
    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['mess'];

      // Chuyển 'result' từ JSON thành danh sách Discount
      List<WalletResponse> wallets = (jsonData['result'] as List)
          .map((json) => WalletResponse.fromJson(json))
          .toList();
      return ApiResult(code, mess, wallets);
    } else {
      throw Exception("WalletRepository_getWalletByUser");
    }
  } catch (e) {
    throw Exception("WalletRepository_getWalletByUser: $e");
  }

  }
}