import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomContainerStatistics(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '120',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Text('أعضاء', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
        Expanded(
          child: CustomContainerStatistics(
            child: Column(
              children: [
                Text(
                  '5',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Text('الحالي', style: TextStyle(fontSize: 15)),
                // Text('منتهية', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
