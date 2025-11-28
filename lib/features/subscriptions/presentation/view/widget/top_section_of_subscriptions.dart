import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/utils/constants.dart';
import 'package:power_gym/core/widget/custom_dropdown_button_widget.dart';
import 'package:power_gym/core/widget/custom_search_widget.dart';

class TopSectionOfSubscriptions extends StatelessWidget {
  const TopSectionOfSubscriptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CustomDropdownButtonWidget(
            items: [
              DropdownMenuItem(value: 'A', child: Text('Active')),
              DropdownMenuItem(value: 'B', child: Text('Expired')),
              DropdownMenuItem(value: 'C', child: Text('Expir')),
            ],
          ),
        ),
        SizedBox(width: 12),
        Text('Status', style: AppStyle.style20),
        SizedBox(width: 28),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: kprimaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomSearchWidget(),
          ),
        ),
      ],
    );
  }
}
