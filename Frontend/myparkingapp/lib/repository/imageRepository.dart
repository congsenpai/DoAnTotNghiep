// ignore_for_file: file_names


import 'dart:convert';

import 'package:myparkingapp/data/model/image.dart';
import 'package:myparkingapp/data/model/parkingLot.dart';
import 'package:http/http.dart' as http;
import '../data/response/apiResponse.dart';
import '../data/model/user.dart';

class ImageRepository{
  Future<APIResult> giveImageByParkingLot(String token, ParkingLot lot) async {
    final String apiUrl = 'http://localhost:8080/smartwalletapp/parkingLot/images/${lot.parkingLotId}';
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
      if(code == 200){
        List<Images> images = imagesDemo;
        APIResult apiResult= APIResult(0,0, code: code, message: message, result: images);
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

  Future<APIResult> giveImageByUser(String token, User user) async {
    final String apiUrl = 'http://localhost:8080/smartwalletapp/users/images/${user.userId}';

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

      if(code == 200){
        Images images = imagesDemo[0];
        APIResult apiResult= APIResult(0,0, code: code, message: message, result: images);
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