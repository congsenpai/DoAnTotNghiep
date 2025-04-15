import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/response/invoice_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

class InvoiceRepository{
  String apiUrl = "http://localhost/myparkingapp";

  Future<ApiResult> getInvoiceByUserWithSearchAndPage(UserResponse user,int page) async{
    try{
        ApiClient apiClient = ApiClient();
        final response = await apiClient.getInvoiceByUserWithSearchAndPage(page, user.userID);
        if(response.statusCode == 200){
            Map<String, dynamic> jsonData = response.data;
            int code = jsonData['code'];
            String mess = jsonData['message'];
            int pageNumber = jsonData['result']['pageNumber'];
            int totalPage = jsonData['result']['totalPages'];
            List<InvoiceResponse> invoices = (jsonData['result']['content'] as List)
            .map((json) => InvoiceResponse.fromJson(json))
            .toList();

            InvoiceOnPage result = InvoiceOnPage(
                invoices, 
                pageNumber,
                totalPage);
            
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


  Future<ApiResult> getCurrentInvoice(String userID) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.returnCurrentInvoice(userID);
      Map<String, dynamic> jsonData = response.data;
      int code = jsonData['code'];
      String mess = jsonData['message'];
      if(code == 200){

        List<InvoiceResponse> invoices = (jsonData['result'] as List)
            .map((json) => InvoiceResponse.fromJson(json))
            .toList();
        List<String> invoiceIDs = invoices.map((e)=>e.invoiceID).toList();

        ApiResult apiResult = ApiResult(
          code,
          mess,
          invoiceIDs,
        );
        return apiResult;
      }
      else{
        ApiResult apiResult = ApiResult(
          code,
          "false",
          null,
        );
        return apiResult;
      }
    }
    catch(e){
      throw Exception(
          "InvoiceRepository_returnCurrentInvoice: $e"
      );
    }
  }

  Future<ApiResult> createdInvoice(InvoiceCreatedDailyRequest? invoiceD,InvoiceCreatedMonthlyRequest? invoiceM) async{
    try{
        ApiClient apiClient = ApiClient();
        late final response;
        if(invoiceD != null){
          response  = await apiClient.invoiceCreatedDaily(invoiceD);
        }
        else{
          response  = await apiClient.invoiceCreatedMonthly(invoiceM!);
        }
        Map<String, dynamic> jsonData = response.data;
        int code = jsonData['code'];
        String mess = jsonData['message'];
        if(code == 200){
            InvoiceResponse invoiceResponse = InvoiceResponse.fromJson(jsonData['result']);
            ApiResult apiResult = ApiResult(
                code,
                mess,
                invoiceResponse,
            );
            return apiResult;
        }
        else{
          ApiResult apiResult = ApiResult(
            code,
            mess,
            null,
          );
          return apiResult;
        }


    }
    catch(e){
        throw Exception(
            "InvoiceRepository_createdInvoice: $e"
        ); 
    }

  }

  Future<ApiResult> getInvoiceByID(String invoiceID) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getInvoiceByID(invoiceID);
      Map<String, dynamic> jsonData = response.data;
      int code = jsonData['code'];
      String mess = jsonData['message'];
      if(code == 200){

        InvoiceResponse invoiceIDs = InvoiceResponse.fromJson( jsonData['result']);

        ApiResult apiResult = ApiResult(
          code,
          mess,
          invoiceIDs,
        );
        return apiResult;
      }
      else{
        ApiResult apiResult = ApiResult(
          code,
          "False",
          null,
        );
        return apiResult;
      }

    }
    catch(e){
      throw Exception(
          "InvoiceRepository_returnInvoice: $e"
      );
    }
  }

  Future<ApiResult> paymentDaily(PaymentDailyRequest request) async{
    try{
      ApiClient apiClient = ApiClient();
      final response  = await apiClient.paymentDaily(request);


        Map<String, dynamic> jsonData = response.data;
        int code = jsonData['code'];
        String mess = jsonData['message'];
        if(code == 200){
          InvoiceResponse invoiceResponse = InvoiceResponse.fromJson(jsonData['result']);
          ApiResult apiResult = ApiResult(
            code,
            mess,
            invoiceResponse,
          );
          return apiResult;
        }


      else{
        ApiResult apiResult = ApiResult(
          code,
          "Failed Payment",
          null,
        );
        return apiResult;
      }
    }
    catch(e){
      throw Exception(
          "InvoiceRepository_createdInvoice: $e"
      );
    }

  }


}