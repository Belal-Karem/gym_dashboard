import 'package:flutter/material.dart';
import 'package:power_gym/features/report/data/models/model/daily_summary_model.dart';

class DailySummary extends StatelessWidget {
  const DailySummary({super.key, required this.s});

  final DailySummaryModel s;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('الدخل'),
            SizedBox(width: 40),
            Text('${s.income}'),
            SizedBox(width: 50),
            Text('الخوارج'),
            SizedBox(width: 40),
            Text('${s.expense}'),
            SizedBox(width: 20),
            ElevatedButton(onPressed: () {}, child: Text('View')),
          ],
        ),
        Divider(),
        Row(children: [Text('total'), SizedBox(width: 40), Text('${s.total}')]),
      ],
    );
  }
}
