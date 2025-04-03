import 'package:dio/dio.dart';
import 'package:myparkingappadmin/data/dto/request/update_user_request.dart';
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';
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

  Future<Response> updateUser(UpdateInfoResquest user, String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/user/$userId/update",
      data:{
        user.toJson()
      },
    );
  }
  Future<Response> changePassWord(String userId, String oldPass, String newPass) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/user/$userId/updatePass",
      data:{
        'userId':userId,
        'oldPassWord':oldPass,
        'newPassWord':newPass
      },
    );
  }

  Future<Response> getParkingLotByOwner(String userId,String search,int page) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/user/$userId/parkinglot/filter?search=$search&page=$page",
    );
  }

  Future<Response> getWalletByCustomer(String userId,String search,int page) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "user/$userId/wallet/filter?search=$search&page=$page"
    );
  }
  
  //----------------------------- PARKINGLOT--------------------------------//

  Future<Response> getParkingSlotByLot(String parkingLotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "paskingLot/$parkingLotID/parkingLot",
    );
  }

  Future<Response> getInvoiceByTimeByLot(String parkingLotID, DateTime start, DateTime end) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "paskingLot/$parkingLotID/invoice/filter?start=$start&end=$end"
    );
  }

  Future<Response> getListDiscountByLot(String parkingSlotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "paskingSlot/$parkingSlotID/discount",
    );
  }
  //--------------------------WALLET------------------------------------//

  Future<Response> getAllWallet({
      required String walletId, 
      required DateTime start,
      required DateTime end,
      required int page,
    }) async {
    final DioClient dioClient = DioClient();
    
    // Tạo URL động tùy theo tham số truyền vào
    String url = "wallet/$walletId/transactions?page=$page";
    return await dioClient.dio.get(url);
  }

  Future<Response> getTransactionsByWallet({
      required String walletId, 
      required TransactionType tranType,
      required DateTime start,
      required DateTime end,
      required int page,
    }) async {
    final DioClient dioClient = DioClient();
    
    // Tạo URL động tùy theo tham số truyền vào
    String url = "wallet/$walletId/transactions?page=$page&type=$tranType$start=$start&end=$end";

    return await dioClient.dio.get(url);
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


}
