// ignore_for_file: file_names, library_private_types_in_public_api, prefer_final_fields, avoid_print, unused_field

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/MainApp/MainAppBloc.dart';
import 'package:myparkingappadmin/bloc/MainApp/MainAppEvent.dart';
import '../../app/localization/app_localizations.dart';
import '../../constants.dart';
import '../../models/discount.dart';
import '../../models/parkingLot.dart';
import 'discountDetail.dart';

class DiscountList extends StatefulWidget {
  final List<Discount> object;
  final String title;
  final HashSet<String> objectColumnName;
  final ParkingLot parkingLot;
  final String token;

  const DiscountList({
    super.key,
    required this.object,
    required this.objectColumnName,
    required this.title,
    required this.parkingLot, required this.token,
  });

  @override
  _DiscountListState createState() => _DiscountListState();
}

class _DiscountListState extends State<DiscountList> {
  TextEditingController _searchController = TextEditingController();
  List<Discount> _filteredDiscountInfos = [];
  late ParkingLot _parkingLot;

  @override
  void initState() {
    super.initState();
    _parkingLot = widget.parkingLot;
    _filteredDiscountInfos = widget.object;
  }

      @override
  void didUpdateWidget(covariant DiscountList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Nếu user thay đổi, cập nhật danh sách thẻ
    if (oldWidget.parkingLot.parkingLotId != widget.parkingLot.parkingLotId) {
      setState(() {
        _filteredDiscountInfos = widget.object.toList();
      });
    }
  }

  void _searchDiscountInfo() {
    setState(() {
      context.read<MainAppBloc>().add(giveDiscountByPageAndSearchEvent(
          widget.parkingLot,
          0,
          _searchController.text,
          widget.token));
      _filteredDiscountInfos = widget.object.toList();
    });
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
                    onSubmitted:(value) => _searchDiscountInfo,
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.blue),
                  onPressed: _searchDiscountInfo,
                ),
                SizedBox(width: 8),
              ],
            ),
            SizedBox(height: defaultPadding),
            // Danh sách thẻ
            _filteredDiscountInfos.isEmpty
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
                        _filteredDiscountInfos.length,
                        (index) => recentFileDataRow(
                          _filteredDiscountInfos[index],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
  DataRow recentFileDataRow(Discount fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.discountCode)),
      DataCell(
        IconButton(
              icon: Icon(Icons.details, color: Colors.green),
              onPressed: ()=>_showDetailDialog(context, fileInfo),
            ),

      ),
      DataCell(
        IconButton(
          icon: Icon(Icons.add, color: Colors.purple),
          onPressed: ()=>_showDetailDialog(context, fileInfo),
        ),

      ),
    ],
  );
}
void _showDetailDialog(BuildContext context, Discount discount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: DiscountDetail(object: discount, title: "DiscountDetail"), // Thay thế bằng widget chi tiết hợp đồng của bạn
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


// Hàm tạo hàng dữ liệu


