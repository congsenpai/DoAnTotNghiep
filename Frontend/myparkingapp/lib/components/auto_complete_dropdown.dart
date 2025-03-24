import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/booking/booking_bloc.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/demo_data.dart';
import '../bloc/booking/booking_event.dart';

class AutocompleteDropDown extends StatefulWidget {
  final List<MonthInfo> months;
  final DiscountResponse discount;
  final ParkingSlotResponse slot;
  final ParkingLotResponse lot;
  final List<DiscountResponse> discounts;
  final DateTime start;
  final MonthInfo month;

  const AutocompleteDropDown({
    super.key,
    required this.months,
    required this.discount,
    required this.slot,
    required this.lot,
    required this.start,
    required this.discounts,
    required this.month,
  });

  @override
  State<AutocompleteDropDown> createState() => _AutocompleteDropDownState();
}

class _AutocompleteDropDownState extends State<AutocompleteDropDown> {
  late MonthInfo _selectedItem;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.month;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            width: 300,
            constraints: BoxConstraints(
              maxHeight: Get.height * 0.5,
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${AppLocalizations.of(context).translate("Select Month")} : ${_selectedItem.monthName}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutocompleteTextField(
                        items: widget.months.map((month) => month.monthName).toList(),
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).translate("Select Month"),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (widget.months.any((e) => e.monthName == val)) {
                            return null;
                          } else {
                            return AppLocalizations.of(context).translate('Invalid Month');
                          }
                        },
                        onItemSelect: (selectedName) {
                          setState(() {
                            _selectedItem = widget.months.firstWhere((element) => element.monthName == selectedName);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<BookingBloc>().add(
                                  BookingCreateInvoiceEvent(
                                    widget.discount,
                                    _selectedItem.start,
                                    widget.lot,
                                    widget.slot,
                                    _selectedItem,
                                    widget.discounts,
                                    widget.months,
                                  ),
                                );
                          }
                        },
                        child: const Text("OK"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------
// AutocompleteTextField
// ------------------------------------

class AutocompleteTextField extends StatefulWidget {
  final List<String> items;
  final Function(String) onItemSelect;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;

  const AutocompleteTextField({
    super.key,
    required this.items,
    required this.onItemSelect,
    this.decoration,
    this.validator,
  });

  @override
  State<AutocompleteTextField> createState() => _AutocompleteTextFieldState();
}

class _AutocompleteTextFieldState extends State<AutocompleteTextField> {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<String> _filteredItems = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: _onFieldChange,
        decoration: widget.decoration,
        validator: widget.validator,
      ),
    );
  }

  void _onFieldChange(String val) {
    setState(() {
      _filteredItems = val.isEmpty
          ? widget.items
          : widget.items.where((element) => element.toLowerCase().contains(val.toLowerCase())).toList();
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    var size = renderBox?.hasSize == true ? renderBox!.size : const Size(300, 50);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height * 0.3),
              child: ListView.builder(
                itemCount: _filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _filteredItems[index];
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      _controller.text = item;
                      _focusNode.unfocus();
                      widget.onItemSelect(item);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
