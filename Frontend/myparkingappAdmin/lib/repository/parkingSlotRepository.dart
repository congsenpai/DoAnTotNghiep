// ignore_for_file: file_names

import 'package:myparkingappadmin/models/parkingLot.dart';
import 'package:myparkingappadmin/models/parkingSlot.dart';
import '../apiResponse.dart';

class ParkingSlotRepository {
  Future<APIResult> giveParkingLotByPageAndSearch(int page, String token, ParkingLot parkingLot,String search) async{
    try{
      List<ParkingSlot> parkingSlots = parkingSlotList
          .where((parkingSlot)=>parkingSlot.parkingLotId.contains(search)&&parkingSlot.parkingLotId == parkingLot.parkingLotId).toList();
      APIResult apiResult = APIResult(1, code: 200, message: "", result: parkingSlots);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}