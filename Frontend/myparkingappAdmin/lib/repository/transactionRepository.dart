// ignore_for_file: file_names

import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';
import 'package:myparkingappadmin/data/dto/response/wallet_response.dart';


import '../apiResponse.dart';


class TransactionRepository {
  Future<APIResult> giveTransactionByPageAndSearch(int page, String token, WalletResponse wallet,String searchText) async{
    try{
      List<TransactionResponse> transactions = demoTransactionList
          .where((transaction)=>transaction.transactionId.contains(searchText)
          && transaction.walletId == wallet.walletId).toList();
      APIResult apiResult = APIResult(1, code: 200, message: "", result: transactions);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}