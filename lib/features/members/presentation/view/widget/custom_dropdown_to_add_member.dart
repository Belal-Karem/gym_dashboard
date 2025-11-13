import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';

class CustomDropdownToAddMember extends StatefulWidget {
  const CustomDropdownToAddMember({
    super.key,
    required this.items,
    this.initialValue,
  });

  final List<DropdownMenuItem<String>> items;
  final String? initialValue;

  @override
  State<CustomDropdownToAddMember> createState() =>
      _CustomDropdownToAddMemberState();
}

class _CustomDropdownToAddMemberState extends State<CustomDropdownToAddMember> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? widget.items.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withAlpha(20)),
        color: Color(0xff1D1E22),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton(
        dropdownColor: Color(0xff1D1E22),
        borderRadius: BorderRadius.circular(12),
        icon: Icon(Icons.keyboard_arrow_down),
        underline: SizedBox(),
        padding: EdgeInsets.only(right: 20),
        style: AppStyle.style20W500,
        value: selectedValue,
        items: widget.items,
        onChanged: (value) {
          selectedValue = value;
          setState(() {});
        },
      ),
    );
  }
}
