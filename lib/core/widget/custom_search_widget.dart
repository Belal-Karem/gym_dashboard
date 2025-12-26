import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({super.key, this.onChanged});

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        border: InputBorder.none,
        hintText: 'بحث',
        hintStyle: TextStyle(fontSize: 18),
        prefixIcon: Icon(Icons.search),
        prefixIconConstraints: BoxConstraints(minWidth: 40),
      ),
    );
  }
}
