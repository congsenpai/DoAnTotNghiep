// ignore_for_file: file_names, library_private_types_in_public_api, prefer_final_fields, avoid_print, unused_field

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/main_app/MainAppBloc.dart';
import 'package:myparkingappadmin/bloc/main_app/MainAppEvent.dart';
import '../../app/localization/app_localizations.dart';
import '../../constants.dart';
import '../../dto/response/parkingLot.dart';
import '../../dto/response/parkingSlot.dart';
import 'parkingSlotDetail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParkingSlotList extends StatefulWidget {
  final List<ParkingSlot> object;
  final String title;
  final HashSet<String> objectColumnName;
  final ParkingLot parkingLot;
  final String token;

  const ParkingSlotList({
    super.key,
    required this.object,
    required this.objectColumnName,
    required this.title,
    required this.parkingLot, required this.token,
  });

  @override
  _ParkingSlotListState createState() => _ParkingSlotListState();
}

class _ParkingSlotListState extends State<ParkingSlotList> {
  TextEditingController _searchController = TextEditingController();
  List<ParkingSlot> _filteredParkingSlot = [];
  late ParkingLot _parkingSlot;
  DateTime? _selectedDate; // Biến lưu ngày tháng được chọn

  @override
  void initState() {
    super.initState();
    _parkingSlot = widget.parkingLot;
    _filteredParkingSlot = widget.object;
  }

      @override
  void didUpdateWidget(covariant ParkingSlotList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Nếu user thay đổi, cập nhật danh sách thẻ
    if (oldWidget.parkingLot.parkingLotId != widget.parkingLot.parkingLotId
  || oldWidget.object != widget.object
    ) {
      setState(() {
        _filteredParkingSlot = widget.object
      .toList();
      });
    }
  }
  void _searchCardInfo(){
    context.read<MainAppBloc>().add(giveParkingSlotByPageAndSearchEvent(
        widget.parkingLot,
        0,
        _searchController.text, widget.token));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 2,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).translate(widget.title),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary
              )
            ),
            SizedBox(height: defaultPadding),

            // Thanh tìm kiếm + Lọc theo ngày
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).translate("Finding..."),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onSubmitted: (value) => _searchCardInfo,
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.blue),
                  onPressed: _searchCardInfo,
                ),

              ],
            ),
            SizedBox(height: defaultPadding),

            // Danh sách thẻ
            _filteredParkingSlot.isEmpty
                ? Container(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Center(
                      child: Text(AppLocalizations.of(context).translate("There is no matching information")),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: defaultPadding,
                      columns: widget.objectColumnName
                          .map((name) => DataColumn(
                                label: Text(
                                  AppLocalizations.of(context).translate(name),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ))
                          .toList(),
                      rows: List.generate(
                        _filteredParkingSlot.length,
                        (index) => recentFileDataRow(
                          _filteredParkingSlot[index],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
  DataRow recentFileDataRow(ParkingSlot fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.slotName)),
      DataCell(Text(fileInfo.slotStatus)),
      DataCell(
        IconButton(
              icon: Icon(Icons.details, color: Colors.green),
              onPressed: ()=>_showDetailDialog(context, fileInfo),
            ),
      ),
      DataCell(
        IconButton(
          icon: const Icon(Icons.content_paste_search_outlined, color: Colors.blueAccent),
          onPressed: () => _showInvoiceList(context, fileInfo),
        ),
      ),
    ],
  );
}
void _showDetailDialog(BuildContext context, ParkingSlot slot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ParkingSlotDetail(object: slot, title: "ParkingSlotDetail"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.cancel, color: Colors.red,),
            ),
          ],
        );
      },
    );
  }
}
void _showInvoiceList(BuildContext context, ParkingSlot slot){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: ParkingSlotDetail(object: slot, title: "InvoiceList"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.cancel, color: Colors.red,),
          ),
        ],
      );
    },
  );
}

// Hàm tạo hàng dữ liệu


