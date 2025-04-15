import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

class TransactionRepository {
  Future<ApiResult> getTransactionByWalletDateTypePage(
    WalletResponse wallet,
    int page,
    Transactions? tranType,
    DateTime? start,
    DateTime? end,
  ) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getTransactions(
        walletId: wallet.walletId,
        page: page,
        tranType: tranType,
        start: start,
        end: end,
      );
      Map<String, dynamic> jsonData = response.data;
      int code = jsonData['code'];
      String mess = jsonData['message'];
      if (response.statusCode == 200) {
        int page = jsonData['result']['page'];
        int pageTotal = jsonData['result']['pageTotal'];
        List<TransactionResponse> trans =
            (jsonData['result']['transactions'] as List)
                .map((json) => TransactionResponse.fromJson(json))
                .toList();

        TransactionOnPage result = TransactionOnPage(trans, page, pageTotal);

        ApiResult apiResult = ApiResult(code, mess, result);
        return apiResult;
      } else {
        ApiResult apiResult = ApiResult(code, mess, null);
        return apiResult;
      }
    } catch (e) {
      throw Exception(
        "TransactionRepository_getTransactionByWalletDateTypePage: $e",
      );
    }
  }

  Future<ApiResult> getTransactionByUserDateTypePage(
    String userID,
    Transactions? tranType,
    DateTime? start,
    DateTime? end,
  ) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getTransactionsByUser(
        userID: userID,
        tranType: tranType,
        start: start,
        end: end,
      );
      Map<String, dynamic> jsonData = response.data;
      int code = jsonData['code'];
      String mess = jsonData['mess'];
      if (code == 200) {
        int page = 1;
        int pageTotal = 1;
        List<TransactionResponse> trans =
            (jsonData['result']['transactions'] as List)
                .map((json) => TransactionResponse.fromJson(json))
                .toList();

        TransactionOnPage result = TransactionOnPage(trans, page, pageTotal);

        ApiResult apiResult = ApiResult(code, mess, result);
        return apiResult;
      } else {
        ApiResult apiResult = ApiResult(code, mess, null);
        return apiResult;
      }
    } catch (e) {
      throw Exception(
        "TransactionRepository_getTransactionByWalletDateTypePage: $e",
      );
    }
  }

  Future<ApiResult> createTransactionByRecharge(
    CreatedTransactionRequest request,
  ) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.createTransactionByRecharge(request);
      Map<String, dynamic> jsonData = response.data;
      int code = jsonData['code'];
      String mess = jsonData['message'];
      ApiResult apiResult = ApiResult(code, mess, null);
      return apiResult;
    } catch (e) {
      throw Exception("TransactionRepository_createTransactionByRecharge: $e");
    }
  }
}
