// ignore_for_file: file_names

import '../data/response/apiResponse.dart';
import '../data/model/parkingLot.dart';
import '../data/model/parkingSlot.dart';

class ParkingSlotRepository {
  Future<APIResult> giveParkingLotByPageAndSearch(int page, String token, ParkingLot parkingLot) async{
    //final String apiUrl = 'http://localhost:8080/smartwalletapp/users/images/${user.userId}';
    try{
      // final response = await http.get(
      //   Uri.parse(apiUrl),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer $token',
      //   },
      // );
      //
      // Map<String, dynamic> responseData = json.decode(response.body);
      // int code = responseData["code"];
      // String message = responseData["message"];
      List<ParkingSlot> parkingSlots = parkingSlotDemo
          .where((parkingSlot)=>parkingSlot.parkingLotId == parkingLot.parkingLotId).toList();
      APIResult apiResult = APIResult(1,0, code: 200, message: "", result: parkingSlots);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }



}