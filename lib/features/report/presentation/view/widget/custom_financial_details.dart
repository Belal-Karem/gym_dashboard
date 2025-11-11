import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';

class CustomFinancialDetails extends StatelessWidget {
  const CustomFinancialDetails({super.key});

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
                  Row(
                    children: [
                      Text('الاشتراكات الجديدة'),
                      SizedBox(width: 40),
                      Text('2'),
                      SizedBox(width: 20),
                      ElevatedButton(onPressed: () {}, child: Text('View')),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text('تجديدات'),
                      SizedBox(width: 40),
                      Text('5'),
                      SizedBox(width: 20),
                      ElevatedButton(onPressed: () {}, child: Text('View')),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text('الدخل'),
                      SizedBox(width: 40),
                      Text('850'),
                      SizedBox(width: 50),
                      Text('الخوارج'),
                      SizedBox(width: 40),
                      Text('100'),
                      SizedBox(width: 20),
                      ElevatedButton(onPressed: () {}, child: Text('View')),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [Text('total'), SizedBox(width: 40), Text('750')],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
