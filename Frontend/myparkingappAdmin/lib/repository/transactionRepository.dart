// ignore_for_file: file_names

import 'package:myparkingappadmin/dto/response/wallet.dart';

import '../apiResponse.dart';
import '../dto/response/transaction.dart';

class TransactionRepository {
  Future<APIResult> giveTransactionByPageAndSearch(int page, String token, Wallet wallet,String searchText) async{
    try{
      List<Transaction> transactions = demoTransactionList
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