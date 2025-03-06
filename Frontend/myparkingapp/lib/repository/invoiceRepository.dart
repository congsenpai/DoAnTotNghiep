// ignore_for_file: file_names

import 'dart:convert';

import 'package:myparkingapp/data/model/user.dart';

import '../data/response/apiResponse.dart';
import '../data/model/invoice.dart';
import 'package:http/http.dart' as http;


class InvoiceRepository {
  Future<APIResult> giveInvoiceByUserPageAndSearch(int page, String token, User user,String searchText) async{
    final String apiUrl = 'http://localhost:8080/smartwalletapp/user/invoice/search/$searchText/page/$page/';
    try{
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Map<String, dynamic> responseData = json.decode(response.body);
      int code = responseData["code"];
      String message = responseData["message"];
      int page = responseData["page"];
      int pageAmount = responseData["pageAmount"];
      code = 200;
      message = 'good';
      page = 1;
      pageAmount = 1;
      if(response.statusCode == 200){
        List<Invoice> invoices = demoInvoices
            .where((invoice)=>invoice.invoiceId.contains(searchText) && invoice.userId == user.userId).toList();
        APIResult apiResult = APIResult(page,pageAmount, code: code, message: message, result: invoices);
        return apiResult;
      }
      else {
        APIResult apiResult= APIResult(0,0, code: code, message: message, result: "null");
        return apiResult;
      }
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}