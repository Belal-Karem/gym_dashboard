import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SignalLikeChart extends StatelessWidget {
  const SignalLikeChart({super.key});

  final active = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 120,
        height: 100,
        child: BarChart(
          BarChartData(
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: 2,
                    color: Colors.red,
                    width: 10,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: 4,
                    color: Colors.red,
                    width: 10,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: 6,
                    color: Colors.red,
                    width: 10,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    toY: 8,
                    color: active
                        ? Colors.red
                        : const Color.fromARGB(82, 244, 67, 54),
                    width: 10,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(
                    toY: 10,
                    color: active
                        ? Colors.red
                        : const Color.fromARGB(82, 244, 67, 54),
                    width: 10,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
