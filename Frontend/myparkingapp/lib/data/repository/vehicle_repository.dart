import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/response/add_vehicle_request.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';

class VehicleRepository{
  Future<ApiResult> addVehicle(CreateVehicleRequest vehicle) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.addVehicle(vehicle);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['message'];
      return ApiResult(code, mess, null);
    } else {
      throw Exception("VehicleRepository_addVehicle");
    }
  } catch (e) {
    throw Exception("VehicleRepository_addVehicle: $e");
  }
  }
  Future<ApiResult> deleteVehicle(String vehicleID) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.deleteVehicle(vehicleID);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;
      int code = jsonData['code'];
      String mess = jsonData['message'];
      return ApiResult(code, mess, "");
    } else {
      throw Exception("VehicleRepository_deleteVehicle");
    }
  } catch (e) {
    throw Exception("VehicleRepository_deleteVehicle: $e");
  }
}
}