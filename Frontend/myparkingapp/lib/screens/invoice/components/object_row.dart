import 'package:flutter/material.dart';

class ObjectRow extends StatelessWidget {
  const ObjectRow({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final dynamic content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        Text(
          content.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }
}
