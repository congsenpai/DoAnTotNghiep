// ignore_for_file: file_names


import 'dart:convert';

import 'package:myparkingapp/data/model/parkingSlot.dart';

import '../data/response/apiResponse.dart';
import '../data/model/parkingLot.dart';
import 'package:http/http.dart' as http;

class ParkingLotRepository {
  Future<APIResult> giveParkingLotByPageAndSearch(int page, String token,String searchText) async{
    final String apiUrl = 'http://localhost:8080/smartwalletapp/parkingLot/search/$searchText/page/$page/';
    try{
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Map<String, dynamic> responseData = json.decode(response.body);
      int code = responseData["code"];
      String message = responseData["message"];
      int page = responseData["page"];
      int pageAmount = responseData["pageAmount"];
      code = 200;
       message = 'good';
      page = 1;
      pageAmount = 1;
      if(response.statusCode == 200){
        List<ParkingLot> parkingLots = parkingLotList
            .where((parkingLot)=>parkingLot.parkingLotName.contains(searchText)).toList();
        APIResult apiResult = APIResult(page,pageAmount, code: code, message: message, result: parkingLots);
        return apiResult;
      }
      else {
        APIResult apiResult= APIResult(0,0, code: code, message: message, result: "null");
        return apiResult;
      }
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }

  Future<APIResult> giveParkingSlotByParkingLot(String token, ParkingLot lot) async {
    final String apiUrl = 'http://localhost:8080/smartwalletapp/parkingLot/parkingSlot/${lot.parkingLotId}';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      json.decode(response.body);
      // int code = responseData["code"];
      // String message = responseData["message"];
      int code = 200;
      String message = 'good';

      if(response.statusCode == 200){
        List<ParkingSlot> slots = parkingSlotDemo.where((slot)=>slot.parkingLotId==lot.parkingLotId).toList();
        APIResult apiResult= APIResult(0,0, code: code, message: message, result: slots);
        return apiResult;
      }
      else {
        APIResult apiResult= APIResult(0,0, code: code, message: message, result: "null");
        return apiResult;
      }
    }
    catch(e){
      throw Exception("updatedUser_repo:  $e");
    }

  }
}