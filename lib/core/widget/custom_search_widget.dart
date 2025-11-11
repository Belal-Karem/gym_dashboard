import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: TextStyle(fontSize: 18),
        prefixIcon: Icon(Icons.search),
        prefixIconConstraints: BoxConstraints(minWidth: 40),
      ),
    );
  }
}
