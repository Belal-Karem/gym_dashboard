import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';

class CustomDropdownToAddMember extends StatefulWidget {
  const CustomDropdownToAddMember({super.key});

  @override
  State<CustomDropdownToAddMember> createState() =>
      _CustomDropdownToAddMemberState();
}

class _CustomDropdownToAddMemberState extends State<CustomDropdownToAddMember> {
  String? selectedValue = '1';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withAlpha(20)),
        color: Color(0xff1D1E22),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton(
        dropdownColor: Color(0xff1D1E22),
        borderRadius: BorderRadius.circular(12),
        icon: Icon(Icons.keyboard_arrow_down),
        underline: SizedBox(),
        padding: EdgeInsets.only(right: 20),
        style: AppStyle.style20W500,
        value: selectedValue,
        items: const [
          DropdownMenuItem(value: '1', child: Text('Male')),
          DropdownMenuItem(value: '2', child: Text('female')),
        ],
        onChanged: (value) {
          selectedValue = value;
          setState(() {});
        },
      ),
    );
  }
}
