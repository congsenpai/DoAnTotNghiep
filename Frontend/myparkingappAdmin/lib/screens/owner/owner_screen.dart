
// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, annotate_overrides, unnecessary_import

import 'dart:collection';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/data/dto/response/discount_response.dart';
import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/responsive.dart';
import 'package:myparkingappadmin/screens/discount/discountList.dart';
import '../../bloc/main_app/MainAppBloc.dart';
import '../../bloc/main_app/MainAppEvent.dart';
import '../../constants.dart';
import '../general/header.dart';
import '../main/components/classInitial.dart';
import '../parkingLot/parkingLotList.dart';
import '../parkingSlot/parkingSlotList.dart';
import 'components/owner_list.dart';


class OwnerScreen extends StatefulWidget {
  final String token;
  final List<UserResponse> owner;
  final List<ParkingLotResponse> parkingLots;
  final List<ParkingSlotResponse> parkingSlots;
  final List<InvoiceResponse> invoices;
  final List<DiscountResponse> discount;
  final bool isAuth;
  final UserResponse user;
  final Function(Locale) onLanguageChange;
  const OwnerScreen({
    super.key, 
    required this.isAuth,
    required this.user,
    required this.owner,
    required this.onLanguageChange,
    required this.token,
    required this.parkingLots,
    required this.parkingSlots,
    required this.invoices,
    required this.discount
  });
  @override
  _OwnerScreenState createState() => _OwnerScreenState();
}
class _OwnerScreenState extends State<OwnerScreen> {

  final HashSet<String> objectColumnNameOfOwner = HashSet.from([
    "FirstName",
    "LastName",
    "Detail",
    "ParkingLotList"
  ]);
  final HashSet<String> objectColumnNameOfParkingLot = HashSet.from([
    "LotID",
    "Name",
    "Detail",
    "SlotList",
    "DiscountList"
  ]);
  final HashSet<String> objectColumnNameOfParkingSlot = HashSet.from([
    "SlotName",
    "SlotStatus",
    "Detail",
    "Invoices List"
  ]);
  final HashSet<String> objectColumnNameOfDiscount = HashSet.from([
    "Code",
    "Detail",
    "Add",

  ]);
  UserResponse selectedUser = selectedUserInitial;
  UserResponse selectedLotOwner = selectedLotOwnerInitial;
  ParkingLotResponse selectedParkingLot = selectedParkingLotInitial;
  ParkingSlotResponse selectedSlot = selectedParkingSlotInitial;

  bool SelectParkingLotList = false;
  bool SelectParkingSlotList = false;
  bool SelectDiscountList = false;
  List<UserResponse> owner = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    owner = widget.owner;
  }
  @override
  void didUpdateWidget(covariant OwnerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.owner != widget.owner) {
      updateOwnerList();
    }
  }

  void updateOwnerList() {
    setState(() {
      owner = widget.owner;
    });
  }

  void updateOwner_Lot(UserResponse user) {
    setState(() {
      context.read<MainAppBloc>().add(giveParkingLotByPageAndSearchEvent(user,0,'',widget.token));
      selectedLotOwner  = user;
      SelectParkingLotList = true;
    });
  }
  void updateParkingLot_Slot(ParkingLotResponse parkingLot){
    setState(() {
      context.read<MainAppBloc>().add(giveParkingSlotByPageAndSearchEvent(parkingLot,0,'',widget.token));
      selectedParkingLot  = parkingLot;
      SelectParkingSlotList = true;
      SelectDiscountList = false;
    });
  }


  void updateParkingLot_Discount(ParkingLotResponse parkingLot){
    setState(() {
      context.read<MainAppBloc>().add(giveDiscountByPageAndSearchEvent(parkingLot,0,'',widget.token));
      selectedParkingLot  = parkingLot;
      SelectParkingSlotList = false;
      SelectDiscountList = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: AppLocalizations.of(context).translate("SpotOwner"),
            user: widget.user,
            isAuth: widget.isAuth, onLanguageChange: widget.onLanguageChange),
            SizedBox(height: defaultPadding),
            Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex:2,
                                child: OwnerList(
                                      object: owner,
                                      objectColumnName: objectColumnNameOfOwner,
                                      title: 'OwnerList',
                                      onOwner_Lot: updateOwner_Lot, token: widget.token,
                                    ),
                              ),
                              if (SelectParkingLotList && Responsive.isDesktop(context))
                                SizedBox(width: Get.width/30,),
                              if (SelectParkingLotList && Responsive.isDesktop(context))
                                Expanded(
                                  flex: 3,
                                  child: ParkingLotList(
                                    object: widget.parkingLots,
                                    objectColumnName: objectColumnNameOfParkingLot,
                                    title: "ParkingSpot",
                                    owner: selectedLotOwner,
                                    onLot_Slot: updateParkingLot_Slot,
                                    onLot_Discount: updateParkingLot_Discount, token: widget.token,),
                                ),
                              if (SelectParkingSlotList && Responsive.isDesktop(context))
                                SizedBox(width: Get.width/30,),
                              if (SelectParkingSlotList && Responsive.isDesktop(context))
                                Expanded(
                                  flex: 2,
                                  child: ParkingSlotList(
                                    object: widget.parkingSlots,
                                    objectColumnName: objectColumnNameOfParkingSlot,
                                    title: "ParkingSlot",
                                    parkingLot: selectedParkingLot, token: widget.token,
                                     ),
                                ),
                              if (SelectDiscountList && Responsive.isDesktop(context))
                                SizedBox(width: Get.width/30,),
                              if (SelectDiscountList && Responsive.isDesktop(context))
                                Expanded(
                                  flex: 2,
                                  child: DiscountList(
                                    object: widget.discount,
                                    objectColumnName: objectColumnNameOfDiscount,
                                    title: 'DiscountList',
                                    parkingLot: selectedParkingLot,
                                    token: widget.token,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: defaultPadding),
                          if (SelectParkingLotList && !Responsive.isDesktop(context))
                            SizedBox(width: Get.height/30,),
                          if (SelectParkingLotList && !Responsive.isDesktop(context))
                            ParkingLotList(
                              object: widget.parkingLots,
                              objectColumnName: objectColumnNameOfParkingLot,
                              title: "ParkingLot",
                              owner: selectedLotOwner,
                              onLot_Slot: updateParkingLot_Slot,
                              onLot_Discount: updateParkingLot_Discount, token: widget.token,),
                          SizedBox(height: defaultPadding),
                          if (SelectParkingSlotList && !Responsive.isDesktop(context))
                            SizedBox(width: Get.height/30,),
                          if (SelectParkingSlotList && !Responsive.isDesktop(context))
                            ParkingSlotList(
                              object: widget.parkingSlots,
                              objectColumnName: objectColumnNameOfParkingSlot,
                              title: "ParkingSlot",
                              parkingLot: selectedParkingLot, token: widget.token,
                            ),

                          if(SelectDiscountList && !Responsive.isDesktop(context))
                            SizedBox(width: Get.height/30,),
                          if(SelectDiscountList && !Responsive.isDesktop(context))
                            DiscountList(
                              object: widget.discount,
                              objectColumnName: objectColumnNameOfDiscount,
                              title: 'DiscountList',
                              parkingLot: selectedParkingLot,
                              token: widget.token,
                            ),
                        ]
                    ),
                )
              ],
            ),
          ]
        ),
      ) 
    );
  }
}

