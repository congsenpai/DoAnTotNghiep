// ignore_for_file: file_names, library_private_types_in_public_api, prefer_final_fields, avoid_print, non_constant_identifier_names

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/main_app/MainAppBloc.dart';
import 'package:myparkingappadmin/bloc/main_app/MainAppEvent.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';

import 'owner_detail.dart';
class OwnerList extends StatefulWidget {
  final String token;
  final List<UserResponse> object;
  final String title;
  final HashSet<String> objectColumnName;
  final Function(UserResponse) onOwner_Lot;
  const OwnerList({
    super.key,
    required this.object,
    required this.objectColumnName,
    required this.title,
    required this.onOwner_Lot, required this.token,
  });
  @override
  _OwnerListState createState() => _OwnerListState();
}
class _OwnerListState extends State<OwnerList> {
  final TextEditingController _searchController = TextEditingController();
  late List<UserResponse> _filteredOwner =[];
  @override
  void initState() {
    super.initState();
    print("_filteredOwner ${widget.object.length}");
    _filteredOwner = widget.object;
  }

  void _searchUser() {
    print("Giá trị searchController.text: '${_searchController.text}'");
    String searchText = _searchController.text.trim().toLowerCase();
    if (searchText.isEmpty) {
      print("Không có dữ liệu trong ô tìm kiếm.");
      return; // Không làm gì nếu ô tìm kiếm trống
    }
    context.read<MainAppBloc>().add(
      giveOwnerByPageAndSearchEvent(0, searchText, widget.token),
    );
  }

  @override
  void didUpdateWidget(covariant OwnerList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.object != widget.object) {
      print("dddddddddd${widget.object.length}");
      setState(() {
        _filteredOwner = widget.object;
      });
    }
  }



  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: defaultPadding),
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
                    onSubmitted: (value) => _searchUser(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.blue),
                  onPressed: _searchUser,
                ),
              ],
            ),
            SizedBox(height: defaultPadding),
            _filteredOwner.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context).translate("There is no matching information"),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: defaultPadding,
                      columns: widget.objectColumnName
                          .map(
                            (name) => DataColumn(
                              label: Text(
                                AppLocalizations.of(context).translate(name),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          )
                          .toList(),
                      rows: _filteredOwner.map((lotOwner) {
                        return _buildDataRow(lotOwner, context);
                      }).toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(UserResponse user, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(user.firstName)),
        DataCell(Text(user.lastName)),
        DataCell(
          IconButton(
            icon: const Icon(Icons.details, color: Colors.green),
            onPressed: () => _showDetailDialog(context, user),
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(Icons.content_paste_search_outlined, color: Colors.blueAccent),
            onPressed: () => widget.onOwner_Lot(user),
          ),
        ),
      ],
    );
  }

  void _showDetailDialog(BuildContext context, UserResponse user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: OwnerDetail(
            object: user,
            isImage: true,
            title: 'CustomerDetail',
          ),
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
