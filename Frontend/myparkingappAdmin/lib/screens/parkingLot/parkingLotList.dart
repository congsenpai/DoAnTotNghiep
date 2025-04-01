// ignore_for_file: library_private_types_in_public_api, avoid_print, non_constant_identifier_names, file_names, unused_element

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/main_app/MainAppBloc.dart';
import 'package:myparkingappadmin/bloc/main_app/MainAppEvent.dart';
import 'package:myparkingappadmin/dto/response/user.dart';


import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';
import '../../dto/response/parkingLot.dart';
import 'parkingLotDetail.dart';

class ParkingLotList extends StatefulWidget {
  final List<ParkingLot> object;
  final String title;
  final HashSet<String> objectColumnName;
  final Function(ParkingLot) onLot_Slot;
  final Function(ParkingLot) onLot_Discount;
  final User owner;
  final String token;

  const ParkingLotList({
    super.key,
    required this.object,
    required this.objectColumnName,
    required this.title,
    required this.onLot_Slot,
    required this.owner, required this.onLot_Discount, required this.token,
  });

  @override
  _ParkingLotListState createState() => _ParkingLotListState();
}

class _ParkingLotListState extends State<ParkingLotList> {
  List<ParkingLot> _filteredContracts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredContracts = widget.object;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
      @override
  void didUpdateWidget(covariant ParkingLotList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.owner.userId != widget.owner.userId || oldWidget.object !=widget.object) {
      setState(() {
        _filteredContracts = widget.object;
      });
    }
  }
  void _filterByValue(){

    print("parking Slot text: ${_searchController.text}");
    setState(() {
      String search = _searchController.text;
      context.read<MainAppBloc>().add(giveParkingLotByPageAndSearchEvent(widget.owner, 0, search, widget.token));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      padding: const EdgeInsets.all(16.0),
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
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            _buildSearchField(),
            SizedBox(height: defaultPadding),
            _filteredContracts.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context).translate("There is no matching information"),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              : _buildDataTable(context),
          ],
        ),
      ),
    );
  }
  Widget _buildSearchField() {
    return Row(
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
            onSubmitted: (_) => _filterByValue(),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.blue),
          onPressed: _filterByValue,
        ),
      ],
    );
  }

  Widget _buildDataTable(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 16.0,
        columns: widget.objectColumnName
            .map((name) => DataColumn(
                  label: Text(AppLocalizations.of(context).translate(name), overflow: TextOverflow.ellipsis, maxLines: 1),
                ))
            .toList(),
        rows: _filteredContracts.map((contract) {
          return _buildDataRow(contract, context);
        }).toList(),
      ),
    );
  }

  DataRow _buildDataRow(ParkingLot parkingLot, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(parkingLot.parkingLotId)),
        DataCell(Text(parkingLot.parkingLotName)),
        DataCell(
          IconButton(
            icon: const Icon(Icons.details, color: Colors.green),
            onPressed: () => _showDetailDialog(context, parkingLot),
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(Icons.content_paste_search_outlined, color: Colors.blueAccent),
            onPressed: () => widget.onLot_Slot(parkingLot),
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(Icons.content_paste_search_outlined, color: Colors.blueAccent),
            onPressed: () => widget.onLot_Discount(parkingLot),
          ),
        ),
      ],
    );
  }

  void _showDetailDialog(BuildContext context, ParkingLot contract) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ParkingSpotDetail(object: contract, title: "ParkingLot"), // Thay thế bằng widget chi tiết hợp đồng của bạn
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:Icon(Icons.cancel, color: Colors.red,),
            ),
          ],
        );
      },
    );
  }
}
