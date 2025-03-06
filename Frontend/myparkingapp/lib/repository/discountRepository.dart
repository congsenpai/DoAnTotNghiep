// ignore_for_file: file_names



import 'dart:convert';

import '../data/response/apiResponse.dart';
import '../data/model/discount.dart';
import '../data/model/parkingLot.dart';
import 'package:http/http.dart' as http;

class DiscountRepository {
  Future<APIResult> giveAllDiscountByPageAndSearch(int page, String token,String searchText) async {
    const String apiUrl = 'http://localhost:8080/smartwalletapp/parkingLot/discount/search';

    try {
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
      code = 200;
      message = 'good';

      if(response.statusCode == 200){
        List<Discount> discounts = demoDiscounts
            .where((discount)=>discount.discountValue.toString().contains(searchText) && discount.discountCode.toLowerCase().contains(searchText) || searchText == '').toList();
        APIResult apiResult= APIResult(0,0, code: code, message: message, result: discounts);
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
  Future<APIResult> giveDiscountByParkingLot(String token, ParkingLot parkingLot) async {
    const String apiUrl = 'http://localhost:8080/smartwalletapp/parkingLot/discount/search';

    try {
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
      code = 200;
      message = 'good';

      if(response.statusCode == 200){
        List<Discount> discounts = demoDiscounts.where((discount) =>
        discount.parkingLotId == parkingLot.parkingLotId
        ).toList();

        APIResult apiResult= APIResult(0,0, code: code, message: message, result: discounts);
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