import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style.dart';
import '../../../../../core/widget/custom_container_statistics.dart';

class StatisticsContainer extends StatelessWidget {
  const StatisticsContainer({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppStyle.style30w500),
          Text(subTitle, style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
