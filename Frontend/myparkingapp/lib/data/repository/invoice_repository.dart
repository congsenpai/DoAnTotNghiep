import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/response/invoice_response.dart';
import 'package:myparkingapp/data/response/user__response.dart';

class InvoiceRepository{
  String apiUrl = "http://localhost/myparkingapp";

  Future<ApiResult> getInvoiceByUserWithSearchAndPage(UserResponse user,String search,int page) async{
    try{
        ApiClient apiClient = ApiClient();
        final response = await apiClient.getInvoiceByUserWithSearchAndPage(search, page, user.userID);
        if(response.statusCode == 200){
            Map<String, dynamic> jsonData = response.data;
            int code = jsonData['code'];
            String mess = jsonData['mess'];
            int page = jsonData['result']['page'];
            int pageAmount = jsonData['result']['pageAmount'];
            List<InvoiceResponse> invoices = (jsonData['result']['invoice'] as List)
            .map((json) => InvoiceResponse.fromJson(json))
            .toList();

            InvoiceOnPage result = InvoiceOnPage(
                invoices, 
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
            "InvoiceRepository_getInvoiceByUserWithSearchAndPage"
        ); 
        }
    }
    catch(e){
        throw Exception(
            "InvoiceRepository_getInvoiceByUserWithSearchAndPage: $e"
        ); 
    }

  }
}