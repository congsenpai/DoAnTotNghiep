import 'dart:convert';
import 'dart:core';

import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/parking_lot.dart';
import 'package:http/http.dart' as http;

import '../data/user.dart';

class LotOnPage{
  final List<ParkingLot> lots;
  final int page;
  final int pageAmount;
  LotOnPage(this.lots,this.page,this.pageAmount);
}

final List<LotOnPage> demo = [
  LotOnPage(parkingLotsDemoPage1, 1, 3),
  LotOnPage(parkingLotsDemoPage2, 2, 3),
  LotOnPage(parkingLotsDemoPage3, 3, 3),
];
class LotRepository{
  final String apiUrl = "";
  Future<ApiResult> getParkingLotList(String token, String searchText, int page, ) async{
    String fullUrl = "";
    try {
      // final response = await http.put(
      //   Uri.parse(fullUrl),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer $token',
      //   },
      // );
      //
      // Map<String, dynamic> responseData = json.decode(response.body);
      // int code = responseData["code"];
      // String message = responseData["message"];
      //
      // if(response.statusCode == 200){
      //   List<ParkingLot> lots;
      //   lots = responseData["result"];
      //
      //   ApiResult apiResult = ApiResult(code, message, lots);
      //   return apiResult;
      // }
      // else {
      //   ApiResult apiResult = ApiResult(code, message, "");
      //   return apiResult;
      // }
      LotOnPage lotOnPage = LotOnPage([], 1, 1);
      lotOnPage = demo[page];
        ApiResult apiResult = ApiResult(200, '', lotOnPage);
        return apiResult;
    }
    catch(e){
      throw Exception("updatedUser_repo:  $e");
    }
  }
  Future<ApiResult> getNearParkingLot(String token, User user ) async{
    String fullUrl = "";
    try {
      // final response = await http.put(
      //   Uri.parse(fullUrl),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer $token',
      //   },
      // );
      //
      // Map<String, dynamic> responseData = json.decode(response.body);
      // int code = responseData["code"];
      // String message = responseData["message"];
      //
      // if(response.statusCode == 200){
      //   List<ParkingLot> lots;
      //   lots = responseData["result"];
      //
      //   ApiResult apiResult = ApiResult(code, message, lots);
      //   return apiResult;
      // }
      // else {
      //   ApiResult apiResult = ApiResult(code, message, "");
      //   return apiResult;
      // }
      List<ParkingLot> lots = parkingLotsDemoPage1;
      ApiResult apiResult = ApiResult(200, '', lots);
      return apiResult;
    }
    catch(e){
      throw Exception("updatedUser_repo:  $e");
    }
  }
}