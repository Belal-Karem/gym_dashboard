import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/home/presentation/view/widget/signal_like_chart.dart';

class MonthlyInDashoard extends StatelessWidget {
  const MonthlyInDashoard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '2,000',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text('الإيرادات اليوميا', style: TextStyle(fontSize: 15)),
            ],
          ),
          SignalLikeChart(),
        ],
      ),
    );
  }
}
