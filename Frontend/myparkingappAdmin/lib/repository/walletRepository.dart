// ignore_for_file: file_names
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';


class WalletRepository {
  Future<ApiResult>  getAllWallet() async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient. getAllWallet();
      int code = response.data["code"];
      String mess = response.data["mess"];
      if(code== 200){
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
      throw Exception(" WalletRepository _getAllWallet: $e");
    }
  }
  Future<ApiResult>  unlockOrUnlockWallet(String walletId, bool newState) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.unlockOrUnlockWallet(walletId, newState);
      int code = response.data["code"];
      String mess = response.data["mess"];
      if(code == 200){
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
      throw Exception(" WalletRepository _unlockOrUnlockWallet: $e");
    }
  }
  Future<ApiResult> getWalletByCustomer(String userId) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getWalletByCustomer(userId);
      int code = response.data["code"];
      String mess = response.data["mess"];
      if(code == 200){
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
      throw Exception(" WalletRepository_getWalletByCustomer: $e");
    }
  }
}