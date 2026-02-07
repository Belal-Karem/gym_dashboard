// ✅ ADDED: Date Picker Function
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> selectDate(
  BuildContext context,
  TextEditingController controller,
) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.dark(
            primary: Color(0xff9D1D1E),
            onPrimary: Colors.white,
            surface: Color(0xff1D1E22),
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    controller.text = DateFormat('yyyy-MM-dd', 'en_US').format(picked);
  }
}
