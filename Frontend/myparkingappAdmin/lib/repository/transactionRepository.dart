// ignore_for_file: file_names
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';


class TransactionRepository {
  Future<ApiResult> getTransactionsByWallet(
      String walletId, 
    ) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getTransactionsByWallet(
      walletId,
    );
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
      throw Exception("ParkingSlotRepository_getParkingSlotByLot: $e");
    }
  }
}