import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/parking_lot.dart';

import '../data/discount.dart';

class DiscountRepository{
  final String apiUrl = "";
  Future<ApiResult> getListDiscountByLot(ParkingLot lot, String token) async{
    String fullApi = apiUrl;
    try{
      List<Discount> discounts = discountDemo.where((discount)=>discount.parkingLotId==lot.parkingLotID).toList();
      ApiResult apiResult = ApiResult(200, "", discounts);
      return apiResult;
    }catch(e){
      throw Exception("_getListDiscountByLot : $e");
    }
  }
}