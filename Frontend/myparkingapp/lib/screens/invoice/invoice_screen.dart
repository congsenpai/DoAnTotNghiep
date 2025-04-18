import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/invoice/invoice_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/bloc/invoice/invoice_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/components/pagination_button.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/main_screen.dart';
import '../../constants.dart';
import '../../data/response/invoice_response.dart';
import 'components/invoice_list.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<InvoiceResponse> invoices = [];
  int page = 1;
  int pageAmount = 1;
  UserResponse user = demoUser;

  @override
  void initState() {
    super.initState();
    context.read<InvoiceBloc>().add(InvoiceInitialEvent(page));
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceBloc,InvoiceState>
      (builder: (context,state) {
        if(state is InvoiceLoadingState){
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
        }
        else if(state is InvoiceLoadedState){
          invoices = state.invoices;
          page = state.page;
          pageAmount = state.pageAmount;
          user = state.user;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                    backgroundColor: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => {
                    Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context)=>MainScreen())
                    )
                  }
                ),
              ),
              title: Text(AppLocalizations.of(context).translate("Your Invoice")),
            ),
            body: SingleChildScrollView(
              child: Padding(
                
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    const SizedBox(height: defaultPadding),
                    // List of cart items
                    ...List.generate(
                      invoices.length,
                          (index) => Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                        child: InvoiceList(invoice: invoices[index],)
                        ),
                      ),
                    PaginationButtons(page: page, pageTotal: pageAmount, onPageChanged: (newPage) {
                        setState(() {
                          page = newPage;
                          context.read<InvoiceBloc>().add(InvoiceInitialEvent(page));// Gọi hàm search
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
        if(state is InvoiceErrorState){
          AppDialog.showErrorEvent(context,AppLocalizations.of(context).translate( state.mess));
        }
    });
  }
}

