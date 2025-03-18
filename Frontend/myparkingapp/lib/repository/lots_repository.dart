import 'dart:convert';
import 'dart:core';

import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/parking_lot.dart';
import 'package:http/http.dart' as http;

import '../data/lot_on_page.dart';
import '../data/user.dart';

class LotRepository{
  final String apiUrl = "";
  Future<ApiResult> getParkingLotList(String token, String searchText, int page) async{
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
      LotOnPage lotOnPage = LotOnPage([], page, 3);
      lotOnPage = demo[page-1];
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