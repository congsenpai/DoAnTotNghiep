import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/discount/discount_bloc.dart';

import 'package:myparkingappadmin/bloc/discount/discount_event.dart';
import 'package:myparkingappadmin/bloc/discount/discount_state.dart';
import 'package:myparkingappadmin/data/dto/response/discount_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import '../../app/localization/app_localizations.dart';
import '../../constants.dart';

import 'discount_detail.dart';

class DiscountList extends StatefulWidget {
  final ParkingLotResponse parkingLot;

  const DiscountList({
    super.key,
    required this.parkingLot,
  });

  @override
  _DiscountListState createState() => _DiscountListState();
}

class _DiscountListState extends State<DiscountList> {
  List<DiscountResponse> discountList = [];
  bool isDetail = false;
  List<String> objectColumnName = [
    'Discount Code',
    'Details',
  ];
  DiscountResponse discountResponse = DiscountResponse(
    discountCode: "",
    discountType: DiscountType.PERCENTAGE,
    discountValue: 0,
    description: "",
    parkingLotId: "",
    discountId: '',
  );

  @override
  void initState() {
    super.initState();
    context.read<DiscountBloc>().add(
          DiscountLoadingScreenEvent(
            widget.parkingLot.parkingLotId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.parkingLot.parkingLotName} / ${AppLocalizations.of(context).translate("Discount List")}"),
      ),
      body: BlocConsumer<DiscountBloc, DiscountState>(
        builder: (context, state) {
          if (state is DiscountLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DiscountLoadedState) {
            discountList = state.discountList;
            return Container(
                height: Get.height,
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: defaultPadding),
                          discountList.isEmpty
                              ? Container(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  child: Center(
                                    child: Text(AppLocalizations.of(context)
                                        .translate(
                                            "There is no matching information")),
                                  ),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  child: DataTable(
                                    columnSpacing: defaultPadding,
                                    columns: objectColumnName
                                        .map((name) => DataColumn(
                                              label: Text(
                                                AppLocalizations.of(context)
                                                    .translate(name),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ))
                                        .toList(),
                                    rows: List.generate(
                                      discountList.length,
                                      (index) => recentFileDataRow(
                                        discountList[index],
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    isDetail
                        ? Expanded(
                            child: DiscountDetail(
                              object: discountResponse,
                            ),
                          )
                        : SizedBox(
                            width: 0,
                          ),
                  ],
                ));
          }
          return Center(
            child: CircularProgressIndicator(),
          ); // Handle other states
        },
        listener: (context, state) {},
      ),
    );
  }

  DataRow recentFileDataRow(DiscountResponse discountInfo) {
    return DataRow(
      cells: [
        DataCell(Text(discountInfo.discountCode)),
        DataCell(
          IconButton(
              icon: Icon(Icons.details, color: Colors.green),
              onPressed: () => {
                    setState(() {
                      discountResponse = discountInfo;
                    }),
                  }),
        ),
        DataCell(
          IconButton(
              icon: Icon(Icons.add, color: Colors.purple),
              onPressed: () => {
                    _showAddDialog(context, discountInfo),
                  }),
        ),
      ],
    );
  }

  void _showAddDialog(BuildContext context, DiscountResponse discountInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(AppLocalizations.of(context).translate("Discount Detail")),
          content: DiscountDetail(object: discountInfo),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context).translate("Close")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
