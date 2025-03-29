import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:myparkingapp/screens/dashboard/dash_board_screen.dart';

class Service {
  final String image;
  final String name;
  final String description;
  final double version;
  final VoidCallback press; // Sự kiện nhấn, dùng để Navigator.push

  Service({
    required this.image,
    required this.name,
    required this.description,
    required this.version,
    required this.press, // Bắt buộc truyền function khi khởi tạo
  });
}


