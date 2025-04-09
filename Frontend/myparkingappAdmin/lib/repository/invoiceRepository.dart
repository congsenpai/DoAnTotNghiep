// ignore_for_file: file_names

import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';

class InvoiceRepository {
  Future<ApiResult> getInvoiceByLot(String parkingLotId) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getInvoiceByLot(parkingLotId);
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
      throw Exception("InvoiceRepository_getInvoiceByLot : $e");
    }
  }
  Future<ApiResult> getInvoiceBySlot(String parkingSlotId) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getInvoiceBySlot(parkingSlotId);
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
      throw Exception("InvoiceRepository_getInvoiceBySlot : $e");
    }
  }
  Future<ApiResult> getAllInvoiceByOwner(String userId) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getAllInvoiceByOwner(userId);
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
      throw Exception("InvoiceRepository_getAllInvoiceByOwner : $e");
    }
  }
    Future<ApiResult> getAllInvoiceByAdmin() async{
    try{
      ApiClient apiClient = ApiClient();

        final response = await apiClient.getAllInvoiceByAdmin();
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
      throw Exception("InvoiceRepository_getAllInvoiceByAdmin: $e");
    }
  }
}