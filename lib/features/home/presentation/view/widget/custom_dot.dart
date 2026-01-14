import 'package:flutter/material.dart';

class CustomNotificationsInt extends StatelessWidget {
  const CustomNotificationsInt({
    super.key,
    required this.text,
    required this.onDelete,
  });

  final String text;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff2A2B30),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: const Color(0xffC93835),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        title: Text(text, style: const TextStyle(color: Colors.white)),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
