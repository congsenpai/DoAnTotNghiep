import 'package:flutter/material.dart';

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

List<Service> services = [
  Service(
    image: 'assets/images/AI_chatbot.png',
    name: 'Chatbot',
    description: 'training by Gemini',
    version: 1.0,
    press: () {
      // Viết logic điều hướng ở đây hoặc pass từ ngoài vào
      print('Đi tới chi tiết dịch vụ 1');
    },
  ),
  Service(
    image: 'assets/images/budget_management.png',
    name: 'Dashboard',
    description: 'budget management',
    version: 1.0,
    press: () {
      print('Đi tới chi tiết dịch vụ 2');
    },
  ),
];
