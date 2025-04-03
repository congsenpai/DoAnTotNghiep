// ignore_for_file: file_names

import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/data/dto/response/wallet_response.dart';


import '../apiResponse.dart';


class WalletRepository {
  Future<APIResult> giveWalletByPageAndSearch(int page, String token, UserResponse user,String searchText) async{
    try{
      List<WalletResponse> walletLists = WalletLists
          .where((parkingLot)=>parkingLot.walletId.contains(searchText)
          && parkingLot.userId == user.userId).toList();
      APIResult apiResult = APIResult(1, code: 200, message: "", result: walletLists);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}