// ignore_for_file: file_names

import 'package:myparkingappadmin/apiResponse.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';

class ParkingLotRepository {
  Future<APIResult> giveParkingLotByPageAndSearch(int page, String token, UserResponse user,String searchText) async{
    try{
      List<ParkingLotResponse> parkingLots = parkingLotList
          .where((parkingLot)=>parkingLot.parkingLotName.contains(searchText) && parkingLot.userId == user.userId).toList();
      APIResult apiResult = APIResult(1, code: 200, message: "", result: parkingLots);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}