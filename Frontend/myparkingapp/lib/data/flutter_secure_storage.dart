import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InvoiceStorageManager {
  static const _storageKey = 'current_invoice';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Lưu danh sách hóa đơn vào storage
  Future<void> saveCurrentInvoice(List<Map<String, String>> invoices) async {
    final map = {"currentInvoice": invoices};
    final jsonStr = jsonEncode(map);
    await _storage.write(key: _storageKey, value: jsonStr);
  }

  /// Lấy danh sách hóa đơn từ storage
  Future<List<Map<String, String>>> getCurrentInvoiceList() async {
    final jsonStr = await _storage.read(key: _storageKey);
    if (jsonStr == null) return [];

    try {
      final decoded = jsonDecode(jsonStr);
      final List<dynamic> rawList = decoded['currentInvoice'] ?? [];
      return rawList.map<Map<String, String>>((item) => Map<String, String>.from(item)).toList();
    } catch (e) {
      return []; // Tránh crash nếu dữ liệu lỗi
    }
  }

  /// Lọc và giữ lại các hóa đơn có key nằm trong danh sách cho trước
  Future<void> filterCurrentInvoice(List<String> keepKeys) async {
    final invoices = await getCurrentInvoiceList();

    final filtered = invoices.where((item) {
      final key = item.keys.first;
      return keepKeys.contains(key);
    }).toList();

    await saveCurrentInvoice(filtered);
  }

  /// Thêm một cặp key-value mới vào danh sách (nếu đã tồn tại thì cập nhật)
  Future<void> addToCurrentInvoice(String key, String value) async {
    final invoices = await getCurrentInvoiceList();

    invoices.removeWhere((item) => item.containsKey(key)); // Xóa key cũ nếu có
    invoices.add({key: value});

    await saveCurrentInvoice(invoices);
  }

  /// Xóa toàn bộ currentInvoice khỏi storage
  Future<void> clearCurrentInvoice() async {
    await _storage.delete(key: _storageKey);
  }
}
