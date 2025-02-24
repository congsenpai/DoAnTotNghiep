// ignore_for_file: file_names

import 'package:myparkingappadmin/models/parkingLot.dart';
import '../apiResponse.dart';
import '../models/discount.dart';

class DiscountRepository {
  Future<APIResult> giveDiscountByPageAndSearch(int page, String token, ParkingLot parkingLot,String searchText) async{
    try{
      List<Discount> discounts = demoDiscounts
          .where((parkingSlot)=>parkingSlot.parkingLotId.contains(searchText)&&parkingSlot.parkingLotId == parkingLot.parkingLotId).toList();
      APIResult apiResult = APIResult(1, code: 200, message: "", result: discounts);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}