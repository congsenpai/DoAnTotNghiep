
import 'dart:core';

import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/request/give_coordinates_request.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
class LotRepository{
  final String apiUrl = "";
  Future<ApiResult> getParkingLotBySearchAndPage(String search, int page) async{
    try{
        ApiClient apiClient = ApiClient();
        final response = await apiClient.getParkingLotBySearchAndPage(search, page);
        if(response.statusCode == 200){
            Map<String, dynamic> jsonData = response.data;
            int code = jsonData['code'];
            String mess = jsonData['mess'];
            int page = jsonData['result']['page'];
            int pageAmount = jsonData['result']['pageAmount'];
            List<ParkingLotResponse> trans = (jsonData['result']['parkingLot'] as List)
            .map((json) => ParkingLotResponse.fromJson(json))
            .toList();

            LotOnPage result = LotOnPage(
                trans, 
                page, 
                pageAmount);
            
            ApiResult apiResult = ApiResult(
                code,
                mess,
                result,
            );
            return apiResult;
        }
        else{
            throw Exception(
            "TransactionRepository_getParkingLotBySearchAndPage"
        ); 
        }
    }
    catch(e){
      throw Exception("TransactionRepository_getParkingLotBySearchAndPage:  $e");
    }
  }
  Future<ApiResult> getNearParkingLot(Coordinates coordinate) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.getNearParkingLot(coordinate);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['mess'];

      // Chuyển 'result' từ JSON thành danh sách Discount
      List<ParkingLotResponse> lots = (jsonData['result'] as List)
          .map((json) => ParkingLotResponse.fromJson(json))
          .toList();

      return ApiResult(code, mess, lots);
    } else {
      throw Exception("LotRepository_getNearParkingLot");
    }
  } catch (e) {
    throw Exception("LotRepository_getNearParkingLot: $e");
  }
  }
}