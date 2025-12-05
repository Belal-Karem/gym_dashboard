import 'package:flutter/material.dart';

class TextFieldAddWidget extends StatelessWidget {
  const TextFieldAddWidget({
    super.key,
    required this.controller,
    this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xff1D1E22)),
      child: TextFormField(
        validator: validator ?? defaultRequiredValidator,
        controller: controller,
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

  String? defaultRequiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'الرجاء ملء البيانات ';
    return null;
  }
}
