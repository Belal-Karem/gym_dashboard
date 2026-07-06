import 'package:flutter/material.dart';

class CustomButtonDateCard extends StatelessWidget {
  const CustomButtonDateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(12, 255, 255, 255),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Text('عرض التقرير', style: TextStyle(color: Colors.white)),
    );
  }
}
