import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SignalLikeChart extends StatelessWidget {
  const SignalLikeChart({super.key, required this.totaltoday});

  final double totaltoday;
  static const double dailyTarget = 3000;
  static const int barsCount = 5;

  @override
  Widget build(BuildContext context) {
    final double stepValue = dailyTarget / barsCount;
    return Center(
      child: SizedBox(
        width: 120,
        height: 100,
        child: BarChart(
          BarChartData(
            maxY: barsCount.toDouble(),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            barGroups: List.generate(barsCount, (index) {
              final barTarget = stepValue * (index + 1);
              final isActive = totaltoday >= barTarget;

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: (index + 1).toDouble(),
                    width: 10,
                    borderRadius: BorderRadius.circular(4),
                    color: isActive
                        ? Colors.red
                        : const Color.fromARGB(82, 244, 67, 54),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
