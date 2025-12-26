import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/constants.dart';
import 'package:power_gym/core/widget/custom_search_widget.dart';

class TopSectionOfPayment extends StatelessWidget {
  const TopSectionOfPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
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
