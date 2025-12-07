import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';

class MembersStatisticsCard extends StatelessWidget {
  const MembersStatisticsCard({
    super.key,
    required this.number,
    required this.text,
    this.textStyle,
  });

  final int number;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number.toString(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          Text(text, style: textStyle ?? TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
