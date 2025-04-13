import 'package:dio/dio.dart';
import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/request/created_wallet_request.dart';
import 'package:myparkingapp/data/request/give_coordinates_request.dart';
import 'package:myparkingapp/data/request/register_user_request.dart';
import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/monthly_ticket_response.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'dio_client.dart';

class ApiClient {
  
    //----------------------------- USER --------------------------------//

  Future<Response> login(String username, String password) async {
    final DioClient dioClient = DioClient();

    return await dioClient.dio.post(
      "auth/login",
      data: {"username": username, "password": password},
    );
  }

  Future<Response> register(
    RegisterUserRequest user
    ) async {
      final DioClient dioClient = DioClient();
      return await dioClient.dio.post(
        "auth/register",
        data:user.toJson(),
      );
    }

  Future<Response> giveEmail(
    String gmail,
    ) async {
      final DioClient dioClient = DioClient();

      return await dioClient.dio.post(
        "auth/giveEmail",
        data: {
          "gmail": gmail,
        },
      );
    }
  Future<Response> giveRePassWord(String newPass, String token) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "auth/reset-password",
       data: {
        "userToken":token,
        "newPassword":newPass,
       },
    );
  }

  Future<Response> refreshToken(String refreshToken) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/refresh",
      data: {"refreshToken": refreshToken},
    );
  }

  Future<Response> getMe() async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/users/profile",
    );
  }
  Future<Response> getUserById(String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/users/id/$userId",
    );
  }

  Future<Response> updateUser(UpdateUserRequest user, String userID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "/users/$userID",
      data:user.toJson(),
    );
  }

  Future<Response> getInvoiceByUserWithSearchAndPage(String search,int page,String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "users/$userId/invoice/search/$search/page/$page",
    );
  }

  Future<Response> getWalletByUser(String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "wallets/user/$userId",
    );
  }

  Future<Response> getTransactionsByUser({
      required String userID, 
      Transactions? tranType,
      DateTime? start,
      DateTime? end,
    }) async {
    final DioClient dioClient = DioClient();
    
    // Tạo URL động tùy theo tham số truyền vào
    String url = "user/$userID/transactions/";
    
    if (tranType != null) {
      url += "&type=$tranType";
    }
    
    if (start != null && end != null) {
      url += "&from=${start.toIso8601String()}&end=${end.toIso8601String()}";
    }

    return await dioClient.dio.get(url);
  }

  Future<Response> changePassWord(String userID, String oldPass, String newPass) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/user/$userID/updatePass",
      data:{
        'userID':userID,
        'oldPassWord':oldPass,
        'newPassWord':newPass
      },
    );
  }
  
  
  //----------------------------- PARKINGLOT--------------------------------//

  Future<Response> getParkingLotBySearchAndPage(String search,int page,int size) async {
    print("________________________________3_____________________");
    final DioClient dioClient = DioClient();
    print("________________________________4_____________________");
    return await dioClient.dio.get(
      "parkinglots?search=$search&page=${page-1}&size=$size",
    );
  }

  Future<Response> getNearParkingLot(Coordinates coordinate) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkingLot/nearby?lat=${coordinate.latitude}&?lon=${coordinate.longitude}",
    );
  }


  Future<Response> getParkingSlotByLot(String parkingLotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkinglots/$parkingLotID/parkingslots",
    );
  }

  Future<Response> getListDiscountByLot(String parkingLotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkinglots/$parkingLotID/discounts",
    );
  }


  //-------------------------SLOT-----------------------------------//



  //-------------------------INVOICE-----------------------------------//

  Future<Response> invoiceCreatedDaily(InvoiceCreatedDailyRequest invoice) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "invoices/daily/deposit",
      data:
        invoice.toJson()

    );
  }
  Future<Response> paymentDaily(PaymentDailyRequest invoice) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
        "invoices/daily/payment",
        data:
          invoice.toJson()

    );
  }
  Future<Response> invoiceCreatedMonthly(InvoiceCreatedMonthlyRequest invoice) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
        "invoices/monthly",
        data:
          invoice.toJson()

    );
  }

  //--------------------------WALLET------------------------------------//

  Future<Response> getTransactions({
      required String walletId, 
      Transactions? tranType,
      DateTime? start,
      DateTime? end,
      required int page,
    }) async {
    final DioClient dioClient = DioClient();
    
    // Tạo URL động tùy theo tham số truyền vào
    String url = "wallet/$walletId/transactions?page=$page";
    
    if (tranType != null) {
      url += "&type=$tranType";
    }
    
    if (start != null && end != null) {
      url += "&from=${start.toIso8601String()}&end=${end.toIso8601String()}";
    }

    return await dioClient.dio.get(url);
  }
  Future<Response> createWallet(CreatedWalletRequest wallet) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "wallet",
      data:{
        wallet.toJson()
      }
    );
  }

  Future<Response> unlockOrUnlockWallet(String walletId, bool newState) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.patch(
      "wallet",
      data:{
        'walletId': walletId,
        'newState': newState,
      }
    );
  }


  //--------------------------Vehicle-----------------------------//

  Future<Response> addVehicle(VehicleResponse request, String userID) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "vehicle",
      data:{
        'VehicleResponse':request,
        'userID':userID
      }
    );
  }

  Future<Response> deleteVehicle(String vehicleID) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.patch(
      "vehicle/$vehicleID/lock",
    );
  }

  Future<Response> getApiClound() async{
    final DioClient dioClient = DioClient();
    // Tạo URL động tùy theo tham số truyền vào
    String url = "getAPICLoundinary";
    return await dioClient.dio.get(url);
  }



}
