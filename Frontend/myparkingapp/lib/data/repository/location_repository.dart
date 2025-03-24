// ignore_for_file: deprecated_member_use

import 'package:geolocator/geolocator.dart';

class LocationRepository {
  /// Kiểm tra quyền truy cập vị trí
  Future<bool> _handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false; // Người dùng từ chối cấp quyền
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false; // Người dùng từ chối quyền vĩnh viễn
    }

    return true;
  }

  /// Lấy vị trí hiện tại (latitude & longitude)
  Future<Position?> getCurrentLocation() async {
    bool hasPermission = await _handlePermission();
    if (!hasPermission) {
      return null; // Không có quyền truy cập vị trí
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
