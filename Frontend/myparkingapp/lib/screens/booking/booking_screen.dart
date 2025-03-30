// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/booking/booking_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
import 'package:myparkingapp/data/response/user__response.dart';
import 'package:myparkingapp/data/response/vehicle__response.dart';
import 'package:myparkingapp/data/response/wallet__response.dart';
import 'package:myparkingapp/demo_data.dart';
import 'package:myparkingapp/screens/invoice/invoice_create.dart';
import '../../bloc/booking/booking_event.dart';
import '../../bloc/booking/booking_state.dart';
import '../../constants.dart';
import '../../data/response/discount_response.dart';
import 'components/info.dart';
import 'components/required_section_title.dart';
import 'components/rounded_checkedbox_list_tile.dart';

class BookingScreen extends StatefulWidget {
  final ParkingLotResponse lot;
  final ParkingSlotResponse slot;
  final UserResponse user;

  const BookingScreen({super.key, required this.lot, required this.slot, required this.user});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool isMonthly = false;
  bool isDate = false;
  bool isShowDiscount = false;
  bool isShowWallet = false;
  bool isVehicle = false;

  DiscountResponse discount = emptyDiscount;
  List<DiscountResponse> discounts = [];
  DateTime start = DateTime.now();
  List<MonthInfo> monthSelect = [];
  List<WalletResponse> wallets = walletdemo;
  WalletResponse wallet = walletdemo[0];
  VehicleResponse vehicle = vehiclesdemo[0];
  List<VehicleResponse> vehicles = vehiclesdemo;
  MonthInfo selectMonth = MonthInfo("March", DateTime(1, 3, 2025), DateTime(31, 3, 2025));

  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(
        BookingInitialInvoiceEvent(discount, start, widget.lot, widget.slot, selectMonth, discounts, monthSelect, wallet, wallets, vehicle,vehicles));
  }

  List<List<T>> splitList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
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
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.zero,
              ),
              child: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: BlocConsumer<BookingBloc, BookingState>(builder: (context, state) {
          if (state is BookingLoadingState) {
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
          } else if (state is BookingLoadedState) {
            discount = state.discount;
            selectMonth = state.month;
            monthSelect = state.monthLists;
            start = state.start;
            discounts = state.discounts;
            wallet = state.wallet;
            wallets = state.wallets;
            vehicle = state.vehicle;
            vehicles = state.vehicles;
            

            return SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Info(lot: widget.lot, slot: widget.slot),
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
                              isActive: (monthOrDate[index] == 'ByMonth' && isMonthly) || (monthOrDate[index] == 'ByDate' && isDate),
                              press: () {
                                setState(() {
                                  isMonthly = monthOrDate[index] == 'ByMonth';
                                  isDate = monthOrDate[index] == 'ByDate';
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: defaultPadding),

                          if (isMonthly) ...[
                            RequiredSectionTitle(title: "Choice Month : ${ selectMonth.monthName}"),
                            const SizedBox(height: defaultPadding),

                            Row(
                              children: splitList(monthSelect, (monthSelect.length / 3).ceil()).map((chunk) {
                                return Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: chunk
                                        .map((month) => RoundedCheckboxListTile(
                                              isActive: (selectMonth.monthName == month.monthName),
                                              text: AppLocalizations.of(context).translate(month.monthName),
                                              press: () {
                                                context.read<BookingBloc>().add(
                                                    BookingInitialInvoiceEvent(discount, start, widget.lot, widget.slot, month, discounts, monthSelect, wallet, wallets, vehicle,vehicles));
                                              },
                                            ))
                                        .toList(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],

                          if (isDate) ...[
                            RequiredSectionTitle(title: "${AppLocalizations.of(context).translate("Start Time ")} :"),
                            SizedBox(height: 8),
                            Text(
                              start.toString(),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],

                          const SizedBox(height: defaultPadding),
                          RequiredSectionTitle(title: "Choice a vehicle :"),
                          // Nút ẩn/hiện Discount
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isVehicle = !isVehicle;
                              });
                            },
                            child: Text("Choice a vehicle : ${vehicle.licensePlate}"  ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Visibility(
                            visible: isVehicle,
                            child: Column(
                              children: [
                                
                                ...vehicles.map((d) => RoundedCheckboxListTile(
                                      isActive: (vehicle.licensePlate == d.licensePlate),
                                      text: "${d.licensePlate} ${  AppLocalizations.of(context).translate(d.vehicleType.name)}",
                                      press: () {
                                        context.read<BookingBloc>().add(
                                            BookingInitialInvoiceEvent(discount, start, widget.lot, widget.slot, selectMonth, discounts, monthSelect, wallet, wallets, d,vehicles));
                                      },
                                    )),
                              ],
                            ),
                          ),

                          const SizedBox(height: defaultPadding),
                          RequiredSectionTitle(title: "Choice a favorite discount :"),
                          // Nút ẩn/hiện Discount
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isShowDiscount = !isShowDiscount;
                              });
                            },
                            child: Text("Choice a favorite discount : ${discount.discountCode}"  ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Visibility(
                            visible: isShowDiscount,
                            child: Column(
                              children: [
                                
                                ...discounts.map((d) => RoundedCheckboxListTile(
                                      isActive: (discount == d),
                                      text: "${d.discountCode} ${  AppLocalizations.of(context).translate(d.discountValue.toString())} ${d.discountType == DiscountType.FIXED ? "VNĐ" : "%"}",
                                      press: () {
                                        context.read<BookingBloc>().add(
                                            BookingInitialInvoiceEvent(d, start, widget.lot, widget.slot, selectMonth, discounts, monthSelect, wallet, wallets, vehicle,vehicles));
                                      },
                                    )),
                              ],
                            ),
                          ),

                          const SizedBox(height: defaultPadding),
                          RequiredSectionTitle(title: "Choice a wallet : "),

                          // Nút ẩn/hiện Wallet
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isShowWallet = !isShowWallet;
                              });
                            },
                            child: Text("Choice a wallet : ${wallet.name}"),
                          ),
                          const SizedBox(height: defaultPadding),
                          Visibility(
                            visible: isShowWallet,
                            child: Column(
                              children: wallets
                                  .map((w) => RoundedCheckboxListTile(
                                        isActive: (wallet == w),
                                        text: "${AppLocalizations.of(context).translate(w.name)} ${w.currency}",
                                        press: () {
                                          context.read<BookingBloc>().add(BookingInitialInvoiceEvent(discount, start, widget.lot, widget.slot, selectMonth, discounts, monthSelect, w, wallets, vehicle,vehicles));
                                        },
                                      ))
                                  .toList(),
                            ),
                          ),

                          const SizedBox(height: defaultPadding),
                          const SizedBox(height: defaultPadding),
                          Center(
                          child: SizedBox(
                            width: Get.width/2,
                            height: Get.width/8,
                            child: ElevatedButton(
                              
                              onPressed: () {
                                isMonthly ? context.read<BookingBloc>().add(GetMonthOderEvent(widget.lot,widget.slot, discount,selectMonth, wallet, vehicle)):
                                context.read<BookingBloc>().add(GetDateOderEvent(widget.lot,widget.slot, discount,start, wallet, vehicle))
                                ;
                              },
                              child:  Text(AppLocalizations.of(context).translate("Booking Now")),
                            ),
                          ),
                        ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
        },listener:(context,state){
            if(state is GotoInvoiceCreateDetailEvent){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>InvoiceCreateScreen(invoice: state.invoice, tran: state.tran, user: widget.user,),
                  ),
                );
            }
            else if (state is BookingErrorState){
              return AppDialog.showErrorEvent(context, state.mess);
            }
          }
        )
        );
  }

  List<String> monthOrDate = ["ByMonth", "ByDate"];
}
