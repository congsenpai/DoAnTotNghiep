// ignore_for_file: file_names

import '../data/response/apiResponse.dart';
import '../data/model/user.dart';
import '../data/model/wallet.dart';


class WalletRepository {
  Future<APIResult> giveWalletByPageAndSearch(int page, String token, User user,String searchText) async{
    try{
      List<Wallet> walletLists = WalletLists
          .where((parkingLot)=>parkingLot.walletId.contains(searchText)
          && parkingLot.userId == user.userId).toList();
      APIResult apiResult = APIResult(1,0, code: 200, message: "", result: walletLists);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}