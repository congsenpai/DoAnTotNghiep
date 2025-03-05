// ignore_for_file: file_names



import '../data/response/apiResponse.dart';
import '../data/model/transaction.dart';
import '../data/model/wallet.dart';


class TransactionRepository {
  Future<APIResult> giveTransactionByPageAndSearch(int page, String token, Wallet wallet,String searchText) async{
    try{
      List<Transaction> transactions = demoTransactionList
          .where((transaction)=>transaction.transactionId.contains(searchText)
          && transaction.walletId == wallet.walletId).toList();
      APIResult apiResult = APIResult(1,0, code: 200, message: "", result: transactions);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }

}