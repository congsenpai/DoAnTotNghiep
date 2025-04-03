// ignore_for_file: file_names

import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';

import '../apiResponse.dart';

class ParkingSlotRepository {
  Future<APIResult> giveParkingLotByPageAndSearch(int page, String token, ParkingLotResponse parkingLot,String search) async{
    try{
      List<ParkingSlotResponse> parkingSlots = parkingSlotList
          .where((parkingSlot)=>parkingSlot.parkingLotId.contains(search)&&parkingSlot.parkingLotId == parkingLot.parkingLotId).toList();
      APIResult apiResult = APIResult(1, code: 200, message: "", result: parkingSlots);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}