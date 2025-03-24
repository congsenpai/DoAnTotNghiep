// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/booking/booking_bloc.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/parking_lot.dart';
import 'package:myparkingapp/data/response/parking_slots.dart';
import 'package:myparkingapp/data/response/user.dart';
import 'package:myparkingapp/demo_data.dart';
import 'package:myparkingapp/screens/invoice/invoice_screen.dart';
import '../../bloc/booking/booking_event.dart';
import '../../bloc/booking/booking_state.dart';
import '../../constants.dart';
import '../../data/response/discount.dart';
import 'components/info.dart';
import 'components/required_section_title.dart';
import 'components/rounded_checkedbox_list_tile.dart';

// ignore: must_be_immutable
class BookingScreen extends StatefulWidget {
  final ParkingLot lot;
  final ParkingSlot slot;
  final User user;

  const BookingScreen({super.key, required this.lot, required this.slot, required this.user});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // for demo we select 2nd one
  bool isMonthly = false;
  bool isDate = false;
  Discount discount = emptyDiscount;
  List<Discount> discounts = [];
  DateTime start = DateTime.now();
  List<MonthInfo> monthSelect = [];
  MonthInfo selectMonth = MonthInfo("March",DateTime(1,3,2025),DateTime(31,3,2025));

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    context.read<BookingBloc>().add(BookingInitialEvent(widget.lot));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              backgroundColor: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.zero,
            ),
            child: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: BlocConsumer<BookingBloc,BookingState>(builder:(context,state){

        if(state is BookingLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }
        else if(state is BookingLoadedState){
          discount = state.discount;
          selectMonth = state.month;
          monthSelect = state.monthLists;
          start = state.start;
          discounts = state.discounts;
          print(monthSelect);


          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Info(lot: widget.lot, slot: widget.slot,),
                  const SizedBox(height: defaultPadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RequiredSectionTitle(title: "Choice"),
                        const SizedBox(height: defaultPadding),
                        ...List.generate(
                          monthOrDate.length,
                              (index) => RoundedCheckboxListTile(
                            text: AppLocalizations.of(context).translate(monthOrDate[index]),
                            isActive: (monthOrDate[index] == 'ByMonth' && isMonthly) || 
                              (monthOrDate[index] == 'ByDate' && isDate),
                            press: () {
                              setState(() {
                                if(monthOrDate[index]=='ByMonth') {
                                  isMonthly = true;
                                  isDate = false;
                                }
                                else{
                                  isMonthly = false;
                                  isDate = true;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        isMonthly?
                        Column(
                          children: [
                          const SizedBox(height: defaultPadding),
                          RequiredSectionTitle(
                              title: "Choice Month"),
                          const SizedBox(height: defaultPadding),
                          
                          ...List.generate(
                            monthSelect.length,
                                (index) => RoundedCheckboxListTile(
                                  isActive: (selectMonth == monthSelect[index] && isMonthly),
                              text: AppLocalizations.of(context).translate(monthSelect[index].monthName),
                              press: () {
                                context.read<BookingBloc>().add(BookingCreateInvoiceEvent(discount, start, widget.lot, widget.slot,monthSelect[index],discounts,monthSelect));
                              },
                            ),
                          ),
                          ],)
                        :
                        SizedBox(height: 8,),
                        isDate?
                        Column(children: [
                          RequiredSectionTitle(title: "${AppLocalizations.of(context).translate("Start Time ")} :"),
                          SizedBox(height: 8,),
                          Text(start.toString(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleLarge,),
                        ],):

                        
                        SizedBox(height: 30,),

                        
                        const SizedBox(height: defaultPadding),
                        RequiredSectionTitle(
                            title: "Choice a favorite discount"),
              
                        const SizedBox(height: defaultPadding),
                        ...List.generate(
                          discounts.length,
                              (index) => RoundedCheckboxListTile(
                                isActive: (discount == discounts[index]),
                                text: "${AppLocalizations.of(context).translate(discounts[index].discountValue.toString())} ${discounts[index].discountType == DiscountType.FIXED ? "VNĐ" : "%"}",
                                press: () {
                                context.read<BookingBloc>().add(BookingCreateInvoiceEvent(discounts[index], start, widget.lot, widget.slot,selectMonth,discounts,monthSelect));
                            },
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        // // Num of item
                        const SizedBox(height: defaultPadding),
                        Center(
                          child: SizedBox(
                            width: Get.width/2,
                            height: Get.width/8,
                            child: ElevatedButton(
                              
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>InvoiceScreen(user: widget.user),
                                  ),
                                );
                              },
                              child:  Text(AppLocalizations.of(context).translate("Booking Now")),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding)
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }, listener:(context,state){
        if(state is BookingSuccessState){
          return AppDialog.showSuccessEvent(context, state.mess);
        }
        else if (state is BookingErrorState){
          return AppDialog.showErrorEvent(context, state.mess);
        };
      })
    );
  }

  List<String> monthOrDate = [
    "ByMonth",
    "ByDate"
  ];
}
