
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/response/parking_lot.dart';

import '../../components/api_result.dart';
import '../response/parking_slots.dart';

class SlotRepository {
  final String apiUrl = "";

  Future<ApiResult> getParkingSlotList(ParkingLot parkingLot) async {
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.getParkingSlotByLot(parkingLot.parkingLotID);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['mess'];

      // Chuyển 'result' từ JSON thành danh sách Discount
      List<ParkingSlot> slots = (jsonData['result'] as List)
          .map((json) => ParkingSlot.fromJson(json))
          .toList();

      return ApiResult(code, mess, slots);
    } else {
      throw Exception("LotRepository_getNearParkingLot");
    }
  } catch (e) {
    throw Exception("LotRepository_getNearParkingLot: $e");
  }
  }


}