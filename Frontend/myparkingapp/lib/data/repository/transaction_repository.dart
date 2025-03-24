import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/transaction__response.dart';
import 'package:myparkingapp/data/response/wallet__response.dart';

class TransactionRepository{
    Future<ApiResult> getTransactionByWalletSearchAndPage(WalletResponse wallet, String search, int page) async{
        try{
            ApiClient apiClient = ApiClient();
            final response = await apiClient.getTransactionByWalletSearchAndPage(wallet.walletId, search, page);
            if(response.statusCode == 200){
                Map<String, dynamic> jsonData = response.data;
                int code = jsonData['code'];
                String mess = jsonData['mess'];
                int page = jsonData['result']['page'];
                int pageAmount = jsonData['result']['pageAmount'];
                List<TransactionResponse> trans = (jsonData['result']['transactions'] as List)
                .map((json) => TransactionResponse.fromJson(json))
                .toList();

                TransactionOnPage result = TransactionOnPage(
                    trans, 
                    page, 
                    pageAmount);
                
                ApiResult apiResult = ApiResult(
                    code,
                    mess,
                    result,
                );
                return apiResult;

            }
            else{
                throw Exception(
                "TransactionRepository_getTransactionByWalletSearchAndPage"
            ); 
            }
        }
        catch(e){
            throw Exception(
                "TransactionRepository_getTransactionByWalletSearchAndPage: $e"
            ); 
        }
    }

    Future<ApiResult> getTransactionByWalletDateTypePage(WalletResponse wallet, Transactions tranType, DateTime start, DateTime end, int page) async{
        try{
            ApiClient apiClient = ApiClient();
            final response = await apiClient.getTransactionByWalletDateTypePage(wallet.walletId, tranType, start, end, page);
            if(response.statusCode == 200){
                Map<String, dynamic> jsonData = response.data;
                int code = jsonData['code'];
                String mess = jsonData['mess'];
                int page = jsonData['result']['page'];
                int pageAmount = jsonData['result']['pageAmount'];
                List<TransactionResponse> trans = (jsonData['result']['transactions'] as List)
                .map((json) => TransactionResponse.fromJson(json))
                .toList();

                TransactionOnPage result = TransactionOnPage(
                    trans, 
                    page, 
                    pageAmount);
                
                ApiResult apiResult = ApiResult(
                    code,
                    mess,
                    result,
                );
                return apiResult;
            }
            else{
                throw Exception(
                "TransactionRepository_getTransactionByWalletDateTypePage"
            ); 
            }
        }
        catch(e){
            throw Exception(
                "TransactionRepository_getTransactionByWalletDateTypePage: $e"
            ); 
        }
    }
    Future<ApiResult> createTransaction(CreatedTransactionRequest transaction) async{
        try{
            ApiClient apiClient = ApiClient();
            final response = await apiClient.createTransaction(transaction);
            if(response.statusCode == 200){
                ApiResult apiResult = ApiResult(
                    response.data['code'],
                    response.data['mess'],
                    response.data['result']
                );
                return apiResult;
            }
            else{
                throw Exception(
                "TransactionRepository_createTransaction"
            ); 
            }
        }
        catch(e){
            throw Exception(
                "TransactionRepository_createTransaction: $e"
            ); 
        }
    }
}