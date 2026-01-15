import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';

class CustomDropdownButtonWidget extends StatefulWidget {
  const CustomDropdownButtonWidget({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
  });

  final List<DropdownMenuItem<String>> items;
  final String? initialValue;
  final void Function(String?)? onChanged;
  @override
  State<CustomDropdownButtonWidget> createState() =>
      _CustomDropdownButtonWidgetState();
}

class _CustomDropdownButtonWidgetState
    extends State<CustomDropdownButtonWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? widget.items.first.value;
  }

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
        items: widget.items,
        onChanged: (value) {
          setState(() => selectedValue = value);
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      ),
    );
  }
}
