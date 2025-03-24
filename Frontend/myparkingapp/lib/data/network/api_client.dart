import 'package:dio/dio.dart';
import 'package:myparkingapp/data/request/coordinates.dart';
import 'package:myparkingapp/data/response/invoice.dart';
import 'package:myparkingapp/data/response/monthly_ticket.dart';
import 'package:myparkingapp/data/response/transaction.dart';
import 'package:myparkingapp/data/response/user.dart';
import 'package:myparkingapp/data/response/wallet.dart';
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
    String username,
    String password,
    String gmail,
    String phoneNumber,
    ) async {
      final DioClient dioClient = DioClient();

      return await dioClient.dio.post(
        "auth/register",
        data: {
          "username": username,
          "password": password,
          "gmail": gmail,
          "phoneNumber": phoneNumber,
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

  Future<Response> updateUser(User user) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/user/${user.userID}/wallet",
      data:{
        "user":user
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
      "/user/$userId/wallet",
    );
  }
  
  
  //----------------------------- PARKINGLOT--------------------------------//

  Future<Response> getParkingLotBySearchAndPage(String search,int page) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/parkingLot/search/$search/page/$page",
    );
  }

  Future<Response> getNearParkingLot(Coordinates coordinate) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/parkingLot/nearlyParking",
      data: {
        "coordinates": coordinate
      },
    );
  }


  Future<Response> getParkingSlotByLot(String parkingLotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/paskingLot/$parkingLotID/parkingLot",
    );
  }


  //-------------------------SLOT-----------------------------------//

  Future<Response> getListDiscountBySlot(String parkingSlotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/paskingSlot/$parkingSlotID/discount",
    );
  }

  //-------------------------INVOICE-----------------------------------//

  Future<Response> createInvoice(Invoice invoice) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/invoice",
      data:{
        'invoice':invoice
      }
    );
  }

  //--------------------------WALLET------------------------------------//

  Future<Response> getTransactionByWalletSearchAndPage(String walletId,String search, int page) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/wallet/$walletId/transactions/search/$search/page/$page",
    );
  }

  Future<Response> getTransactionByWalletDateTypePage(String walletId, Transactions tranType, DateTime start, DateTime end, int page)async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/wallet/$walletId/transactions/type/$tranType/from/$start/end/$end/page/$page",
    );
  }

  Future<Response> createWallet(Wallet wallet) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/wallet",
      data:{
        'wallet':wallet
      }
    );
  }

  Future<Response> unlockOrUnlockWallet(String walletId, bool newState) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.patch(
      "/wallet",
      data:{
        'walletId': walletId,
        'newState': newState,
      }
    );
  }


  //--------------------------TRANSACTION-------------------------------//

    Future<Response> createTransaction(Transaction transaction) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/wallet",
      data:{
        'transaction':transaction
      }
    );
  }


  //--------------------------MONTH TICKET-----------------------------//

  Future<Response> createMonthTicket(MonthlyTicket monthlyTicket) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/monthlyTicket",
      data:{
        'monthlyTicket':monthlyTicket
      }
    );
  }



}
