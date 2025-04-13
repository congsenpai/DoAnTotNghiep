
import 'dart:core';

import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/request/give_coordinates_request.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
class LotRepository{
  final String apiUrl = "";
  Future<ApiResult> getParkingLotBySearchAndPage(String search, int page, int size) async{
    try{
        ApiClient apiClient = ApiClient();
        final response = await apiClient.getParkingLotBySearchAndPage(search, page, size);
        if(response.statusCode == 200){
            Map<String, dynamic> jsonData = response.data;
            int code = jsonData['code'];
            String mess = jsonData['message'];
            int pageNumber = jsonData['result']['pageNumber'];
            int totalPages = jsonData['result']['totalPages'];
            List<ParkingLotResponse> lots = jsonData['result']['content'] != null ? (jsonData['result']['content'] as List)
            .map((json) => ParkingLotResponse.fromJson(json))
            .toList() : [];

            LotOnPage result = LotOnPage(
                lots,
                pageNumber+1,
                totalPages);
            
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
      List<ParkingLotResponse> lots = jsonData['result'] !=null ? (jsonData['result'] as List)
          .map((json) => ParkingLotResponse.fromJson(json))
          .toList() : [];

      return ApiResult(code, mess, lots);
    } else {
      throw Exception("LotRepository_getNearParkingLot");
    }
  } catch (e) {
    throw Exception("LotRepository_getNearParkingLot: $e");
  }
  }
}