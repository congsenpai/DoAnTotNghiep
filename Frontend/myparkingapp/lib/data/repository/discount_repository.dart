import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
class DiscountRepository{
  final String apiUrl = "";
  Future<ApiResult> getListDiscountBySlot(ParkingSlotResponse slot) async {
  try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.getListDiscountBySlot(slot.slotID);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['mess'];

      // Chuyển 'result' từ JSON thành danh sách Discount
      List<DiscountResponse> discounts = (jsonData['result'] as List)
          .map((json) => DiscountResponse.fromJson(json))
          .toList();

      return ApiResult(code, mess, discounts);
    } else {
      throw Exception("DiscountRepository_getListDiscountByLot");
    }
  } catch (e) {
    throw Exception("DiscountRepository_getListDiscountByLot: $e");
  }
}
}