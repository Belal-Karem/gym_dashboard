import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/format_date_helper.dart';
import 'package:power_gym/core/utils/app_style.dart';

class ItemDisplayDataForMember extends StatelessWidget {
  const ItemDisplayDataForMember({
    super.key,
    required this.label,
    this.child,
    this.child2,
  });

  final String label;
  final String? child2, child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text('$label :', style: AppStyle.style20W500),
          Text(
            ' ${FormatDateHelper.formatDate(child)}',
            style: AppStyle.style20.copyWith(
              color: Colors.white.withAlpha(200),
            ),
          ),
          Text(
            ' ${child2}',
            style: AppStyle.style20.copyWith(
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }
}
