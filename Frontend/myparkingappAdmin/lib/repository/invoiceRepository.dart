// ignore_for_file: file_names

import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';

import '../apiResponse.dart';


class InvoiceRepository {
  Future<APIResult> giveInvoiceByPageAndSearch(int page, String token, ParkingSlotResponse parkingSlot,String searchText) async{
    try{
      List<InvoiceResponse> invoices = demoInvoices
          .where((invoice)=>invoice.invoiceId.contains(searchText) && invoice.parkingSlotId == parkingSlot.parkingLotId).toList();
      APIResult apiResult = APIResult(1, code: 200, message: "", result: invoices);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}