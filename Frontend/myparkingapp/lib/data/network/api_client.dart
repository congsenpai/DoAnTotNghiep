import 'package:dio/dio.dart';
import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/request/created_wallet_request.dart';
import 'package:myparkingapp/data/request/give_coordinates_request.dart';
import 'package:myparkingapp/data/request/register_user_request.dart';
import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/monthly_ticket_response.dart';
import 'package:myparkingapp/data/response/transaction__response.dart';
import 'package:myparkingapp/data/response/vehicle__response.dart';
import 'package:myparkingapp/data/response/wallet__response.dart';
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
        data: {
          user.toJson()
        },
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
    return await dioClient.dio.post(
      "auth/UpdatePassWord",
       data: {
        "acceptToken":token,
        "password":newPass,
       },
    );
  }

  Future<Response> refreshToken(String refreshToken) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/refresh-token",
      data: {"refresh_token": refreshToken},
    );
  }

  Future<Response> getUserByUserName(String userName) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/user/$userName",
    );
  }

  Future<Response> updateUser(UpdateUserRequest user) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/user/${user.userID}/update",
      data:{
        user.toJson()
      },
    );
  }

  Future<Response> getInvoiceByUserWithSearchAndPage(String search,int page,String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "user/$userId/invoice/search/$search/page/$page",
    );
  }

  Future<Response> getWalletByUser(String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "user/$userId/wallet",
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

  Future<Response> getParkingLotBySearchAndPage(String search,int page) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkingLot/search/$search/page/$page",
    );
  }

  Future<Response> getNearParkingLot(Coordinates coordinate) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "parkingLot/nearlyParking",
      data: {
        coordinate.toJson()
      },
    );
  }


  Future<Response> getParkingSlotByLot(String parkingLotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "paskingLot/$parkingLotID/parkingLot",
    );
  }


  //-------------------------SLOT-----------------------------------//

  Future<Response> getListDiscountBySlot(String parkingSlotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "paskingSlot/$parkingSlotID/discount",
    );
  }

  //-------------------------INVOICE-----------------------------------//

  Future<Response> createInvoice(CreatedInvoiceRequest invoice) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "invoice",
      data:{
        invoice.toJson()
      }
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


  //--------------------------TRANSACTION-------------------------------//

    Future<Response> createTransaction(CreatedTransactionRequest transaction) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "wallet",
      data:{
        transaction.toJson()
      }
    );
  }


  //--------------------------MONTH TICKET-----------------------------//

  Future<Response> createMonthTicket(MonthlyTicketResponse monthlyTicket) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "monthlyTicket",
      data:{
        'monthlyTicket':monthlyTicket
      }
    );
  }

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



}
