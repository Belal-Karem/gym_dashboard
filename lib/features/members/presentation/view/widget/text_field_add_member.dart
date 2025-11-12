import 'package:flutter/material.dart';

class TextFieldAddMember extends StatelessWidget {
  const TextFieldAddMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xff1D1E22)),
      child: TextField(
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withAlpha(100)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withAlpha(20)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withAlpha(120)),
          ),
        ),
      ),
    );
  }
}
