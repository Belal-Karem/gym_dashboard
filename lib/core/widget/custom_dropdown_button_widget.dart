import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/constants.dart';

class CustomDropdownButtonWidget extends StatefulWidget {
  const CustomDropdownButtonWidget({super.key});

  @override
  State<CustomDropdownButtonWidget> createState() =>
      _CustomDropdownButtonWidgetState();
}

class _CustomDropdownButtonWidgetState
    extends State<CustomDropdownButtonWidget> {
  String? selectedValue = 'A';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kprimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton(
        dropdownColor: kprimaryColor,
        borderRadius: BorderRadius.circular(12),
        icon: Icon(Icons.keyboard_arrow_down),
        underline: SizedBox(),
        padding: EdgeInsets.only(right: 20),
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
        value: selectedValue,
        items: const [
          DropdownMenuItem(value: 'A', child: Text('Active')),
          DropdownMenuItem(value: 'B', child: Text('Expired')),
          DropdownMenuItem(value: 'C', child: Text('Expir')),
        ],
        onChanged: (value) {
          selectedValue = value;
          setState(() {});
        },
      ),
    );
  }
}
