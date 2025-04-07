import 'package:dio/dio.dart';
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_owner_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/create_discount_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_discount_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_parking_lot_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_parking_slot_request.dart';
import 'package:myparkingappadmin/data/dto/request/update_user_request.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
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

  Future<Response> register(CreateParkingOwnerRequest request) async {
    final DioClient dioClient = DioClient();

    return await dioClient.dio.post(
      "auth/register",
      data: {"user": request},
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

  Future<Response> getAllCustomerUser(String search) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "user/customer",
    );
  }
  Future<Response> getAllOwnerUser(String search) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "user/owner",
    );
  }

  Future<Response> updateUser(UpdateInfoResquest user, String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "user/$userId/update",
      data:{
        user.toJson()
      },
    );
  }

  Future<Response> updateStatusUser(UserStatus newStatus, String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "user/$userId/update",
      data:{
        "newStatus":newStatus
      },
    );
  }

  Future<Response> changePassWord(String userId, String oldPass, String newPass) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "user/$userId/updatePass",
      data:{
        'userId':userId,
        'oldPassWord':oldPass,
        'newPassWord':newPass
      },
    );
  }

  
  //----------------------------- PARKINGLOT--------------------------------//
  Future<Response> updateStatusParkingLot( LotStatus newStatus, String parkingLotId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "user/$parkingLotId/update",
      data:{
        "newStatus":newStatus
      },
    );
  }
  Future<Response> getParkingLotByOwner(String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "user/$userId/parkinglots",
    );
  }
  Future<Response> updateParkingLot(String parkingLotId, UpdateParkingLotRequest request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "paskingLot/$parkingLotId/update",
      data:{
        'parkingSlot': request.toJson(),
      }
    );
  }
  
  //--------------------------PARKING SLOT------------------------------------//

  Future<Response> getParkingSlotByLot(String parkingLotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "paskingLot/$parkingLotID/parkingLot",
    );
  }
  Future<Response> updateParkingSlot(String parkingSlotID, UpdateParkingSlotResponse request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "paskingSlot/$parkingSlotID/update",
      data:{
        'parkingSlot': request.toJson(),
      }
    );
  }
  

  //--------------------------DISCOUNT------------------------------------//

  Future<Response> createDiscount( CreateDiscountResquest request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "discount",
      data:{
        "discount": request.toJson(),
      }
    );
  }
  Future<Response> updateDiscount(String discountId, UpdateDiscountResquest request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "discount/$discountId/update",
      data:{
        'discountCode': request.toJson(),
      }
    );
  }
  Future<Response> getListDiscountByLot(String parkingSlotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "paskingSlot/$parkingSlotID/discount",
    );
  }
  Future<Response> deleteDiscount(String discountId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.delete(
      "discount/$discountId/delete",
    );
  }


  //--------------------------INVOICE------------------------------------//

  Future<Response> getInvoiceByTimeByLot(String parkingLotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "paskingLot/$parkingLotID/invoice"
    );
  }
  Future<Response> getInvoiceBySlot(String parkingSlotId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "paskingSlot/$parkingSlotId/invoice",
    );
  }
  Future<Response> getInvoiceByLot(String parkingLotId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "paskingSlot/$parkingLotId/invoice",
    );
  }
  //--------------------------WALLET------------------------------------//

  Future<Response> getAllWallet() async {
    final DioClient dioClient = DioClient();
    
    // Tạo URL động tùy theo tham số truyền vào
    String url = "wallet";
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

  Future<Response> getWalletByCustomer(String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "user/$userId/wallets"
    );
  }

  //--------------------------TRANSACTION------------------------------------//
  
  Future<Response> getTransactionsByWallet(
      String walletId,
    ) async {
    final DioClient dioClient = DioClient();
    
    // Tạo URL động tùy theo tham số truyền vào
    String url = "wallet/$walletId/transactions";

    return await dioClient.dio.get(url);
  }
}
