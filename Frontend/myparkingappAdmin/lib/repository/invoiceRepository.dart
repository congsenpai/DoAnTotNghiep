// ignore_for_file: file_names

import '../apiResponse.dart';
import '../dto/response/invoice.dart';
import '../dto/response/parkingSlot.dart';

class InvoiceRepository {
  Future<APIResult> giveInvoiceByPageAndSearch(int page, String token, ParkingSlot parkingSlot,String searchText) async{
    try{
      List<Invoice> invoices = demoInvoices
          .where((invoice)=>invoice.invoiceId.contains(searchText) && invoice.parkingSlotId == parkingSlot.parkingLotId).toList();
      APIResult apiResult = APIResult(1, code: 200, message: "", result: invoices);
      return apiResult;
    }
    catch(e){
      throw Exception("Lỗi kết nối: $e");
    }
  }
}