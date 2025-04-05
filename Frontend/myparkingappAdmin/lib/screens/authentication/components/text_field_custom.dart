
import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController editController;
  final String title;
  final bool isEdit; 
  int? height;

  TextFieldCustom({
    super.key,
    required this.editController,
    required this.title, required this.isEdit,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.toDouble() ?? 50, // ✅ Chiều cao của TextField
      child: TextFormField(
        enabled: isEdit, // ✅ Cho phép chỉnh sửa hay khôn
        controller: editController,
        cursorColor: Theme.of(context).colorScheme.primary, // ✅ Màu con trỏ
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary, // ✅ Màu chữ trong ô nhập
        ),
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary, // ✅ Màu label khi chưa focus
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface, // ✅ Màu nền
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary, // ✅ Border khi chưa focus
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, // ✅ Border khi focus
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.shade400, // ✅ Border khi TextField bị disabled
              width: 1,
            ),
          ),
        ),
      )

    );
  }
}

class TextFieldCustom2 extends StatelessWidget {
  final TextEditingController? editController;
  final String title;
  final bool isEdit;
  final int? height;

  // Thêm cho dropdown
  final bool isDropdown;
  final List<String>? dropdownItems;
  final String? selectedValue;
  final Function(String?)? onChanged;

  const TextFieldCustom2({
    super.key,
    this.editController,
    required this.title,
    required this.isEdit,
    this.height,
    this.isDropdown = false,
    this.dropdownItems,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.toDouble() ?? 50,
      child: isDropdown
          ? DropdownButtonFormField<String>(
              value: selectedValue,
              items: dropdownItems
                  ?.map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              onChanged: isEdit ? onChanged : null,
              decoration: InputDecoration(
                labelText: title,
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
              ),
            )
          : TextFormField(
              enabled: isEdit,
              controller: editController,
              cursorColor: Theme.of(context).colorScheme.primary,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              decoration: InputDecoration(
                labelText: title,
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
              ),
            ),
    );
  }
}
