import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/payment/payment_event.dart';
import 'package:myparkingapp/bloc/payment/payment_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/transaction_repository.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/transaction__response.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

class PaymentBloc extends Bloc<PaymentEvent,PaymentState>{
  PaymentBloc():super(PaymentInitialState()){
    on<GetPaymentEvent>(onPayment);
  }

  Future<void> onPayment(GetPaymentEvent event, Emitter<PaymentState> emit) async {
    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url:
      'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
      version: '2.0.1',
      tmnCode: 'CVXOW51B', //vnpay tmn code, get from vnpay
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      orderInfo: event.orderInfo, //order info, default is Pay Order
      amount: event.amount,
      returnUrl:
      'xxxxxx', //https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
      ipAdress: '192.168.10.10',
      vnpayHashKey: 'WN9I2JRPC6ASCWQ1XS8C94WYEYJFCTR5', //vnpay hash key, get from vnpay
      vnPayHashType: VNPayHashType
          .HMACSHA512, //hash type. Default is HMACSHA512, you can chang it in: https://sandbox.vnpayment.vn/merchantv2,
      vnpayExpireDate: DateTime.now().add(const Duration(hours: 1)),
      currencyCode: 'VND'
    );
    await VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (params) async {
        String? responseCode = params["vnp_ResponseCode"];
        if (responseCode == "00"){
          CreatedTransactionRequest tranREQ = CreatedTransactionRequest
            (currentBalance: event.amount, description: event.orderInfo, type: Transactions.TOP_UP, walletId: event.wallet.walletId);
            TransactionRepository tran = TransactionRepository();
            ApiResult apiResult = await tran.createTransaction( tranREQ);
              if(apiResult.code == 200){
                emit(PaymentSuccessState("successful transaction"));
              }
              else{
                emit(PaymentSuccessState("failed transaction"));
              }
        }
        },
      onPaymentError: (params) {
        String errorMessage = params["message"] ?? "Unknown error";
        emit(PaymentSuccessState("failed transaction $errorMessage"));
      },
    );
  }
}
