
import 'package:myparkingapp/data/data_on_floor.dart';
import 'package:myparkingapp/data/parking_lot.dart';

import '../components/api_result.dart';
import '../data/parking_slots.dart';

class SlotRepository {
  final String apiUrl = "";

  Future<ApiResult> getParkingLotList(String token, ParkingLot parkingLot) async {
    String fullUrl = "";
    try {
      // final response = await http.put(
      //   Uri.parse(fullUrl),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer $token',
      //   },
      // );
      //
      // Map<String, dynamic> responseData = json.decode(response.body);
      // int code = responseData["code"];
      // String message = responseData["message"];
      //
      // if(response.statusCode == 200){
      //   List<ParkingLot> lots;
      //   lots = responseData["result"];
      //
      //   ApiResult apiResult = ApiResult(code, message, lots);
      //   return apiResult;
      // }
      // else {
      //   ApiResult apiResult = ApiResult(code, message, "");
      //   return apiResult;
      // }
      List<DataOnFloor> dataOnFloors = [];
      List<Slot> slots = demoSlots
          .where((slot) => slot.lotId == parkingLot.parkingLotID)
          .toList();
      Set<String> floorNames = demoSlots.map((slot) => slot.floorName).toSet();
      for (var floor in floorNames) {
        List<Slot> slots = demoSlots
            .where((slot) => slot.floorName == floor)
            .toList();
        DataOnFloor dataOnFloor = DataOnFloor(floor, slots);

        dataOnFloors.add(dataOnFloor);
      }
      ApiResult apiResult = ApiResult(200, '', dataOnFloors);
      return apiResult;
    }
    catch (e) {
      throw Exception("updatedUser_repo:  $e");
    }
  }
}