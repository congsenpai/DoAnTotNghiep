import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/transaction/transaction_bloc.dart';
import 'package:myparkingapp/bloc/transaction/transaction_event.dart';
import 'package:myparkingapp/bloc/transaction/transaction_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/components/pagination_button.dart';
import 'package:myparkingapp/data/response/transaction__response.dart';
import 'package:myparkingapp/data/response/wallet__response.dart';
import 'package:myparkingapp/screens/transaction/component/Transaction_list.dart';
import 'package:myparkingapp/screens/transaction/component/filter_transaction.dart';
import '../../constants.dart';

class TransactionScreen extends StatefulWidget {
  final WalletResponse wallet;

  const TransactionScreen({super.key, required this.wallet});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<TransactionResponse> trans = [];
  int page = 1;
  int pageTotal = 1;
  String searchText = "";
  Transactions type = Transactions.PAYMENT;
  DateTime start = DateTime(2020,12,20);
  DateTime end= DateTime.now();
  bool _fillScreen = false;
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(LoadAllTransactionEvent(widget.wallet,page));
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionBloc,TransactionState>
      (builder: (context,state) {
        if(state is TransactionLoadingState){
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
        }
        else if(state is TransactionLoadedState){
          trans = state.trans;
          page = state.page;
          pageTotal = state.pageTotal;
          type = state.type;
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).translate("Your Transactions")),
              actions: [
                IconButton(onPressed: (){
                  setState(() {
                    _fillScreen = !_fillScreen;
                  });
                }, icon: Icon(Icons.filter))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    const SizedBox(height: defaultPadding),
                    _fillScreen?FilterTransaction(type: type, start: start, end: end, wallet: widget.wallet, trans: trans):
                    const SizedBox(height: defaultPadding),
                    // List of cart items
                    ...List.generate(
                      trans.length,
                          (index) => Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                        child: TransactionItem(tran: trans[index],)
                        ),
                      ),
                    PaginationButtons(page: page, pageTotal: pageTotal, onPageChanged: (newPage) {
                        setState(() {
                          page = newPage;
                          context.read<TransactionBloc>().add(LoadTransactionEvent(widget.wallet, end, start, type, page));// Gọi hàm search
                        });
                        // Gọi API hoặc cập nhật dữ liệu cho trang mới
                      },)
                  ],
                ),
              ),
            ),
          );

        }
        return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
    }, listener: (context,state){
        if(state is TransactionErrorState){
          AppDialog.showErrorEvent(context, state.mess);
        }
    });
  }
}



