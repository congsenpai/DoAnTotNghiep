// ignore_for_file: file_names

import 'package:myparkingappadmin/data/dto/response/discount_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';

import '../apiResponse.dart';

class DiscountRepository {
  Future<APIResult> giveDiscountByPageAndSearch(int page, String token, ParkingLotResponse parkingLot,String searchText) async{
    try{
      List<DiscountResponse> discounts = demoDiscounts
          .where((parkingSlot)=>parkingSlot.parkingLotId.contains(searchText)&&parkingSlot.parkingLotId == parkingLot.parkingLotId).toList();
      APIResult apiResult = APIResult(1, code: 200, message: "", result: discounts);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}