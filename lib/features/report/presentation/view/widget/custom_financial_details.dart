import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';

import 'package:power_gym/features/report/presentation/view/widget/Subscription_data.dart';
import 'package:power_gym/features/report/presentation/view/widget/daily_summary_data.dart';

class CustomFinancialDetails extends StatelessWidget {
  const CustomFinancialDetails({super.key, required this.date});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('ملخص', style: AppStyle.style20W500),
        Expanded(
          child: CustomContainerStatistics(
            padding: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SubscriptionData(date: date),
                  Divider(),
                  DailySummaryData(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
