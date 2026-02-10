import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/format_date_helper.dart';
import 'package:power_gym/core/utils/app_style.dart';

class ItemDisplayDataForHistory extends StatelessWidget {
  const ItemDisplayDataForHistory({
    super.key,
    required this.label,
    this.child,
    this.child2,
    required this.style,
  });

  final String label;
  final String? child2, child;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            '$label :',
            style: AppStyle.style15.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            ' ${FormatDateHelper.formatDate(child)}',
            style: AppStyle.style15.copyWith(),
          ),
          Text(' ${child2}', style: style ?? AppStyle.style15.copyWith()),
        ],
      ),
    );
  }
}
