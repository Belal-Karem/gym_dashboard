import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/subscriptions/presentation/view/widget/top_section_of_subscriptions.dart';

class SubscriptionsBody extends StatelessWidget {
  const SubscriptionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الاشتركات',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          TopSectionOfSubscriptions(),
          SizedBox(height: 15),
          Expanded(
            child: CustomContainerStatistics(
              padding: 0,
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: Colors.white.withOpacity(0.15),
                      width: 0.5,
                    ),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(1.2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1.2),
                  },
                  children: [
                    TableHelper.buildHeaderRow([
                      TableHeaderCellWidget('اسم الخطه'),
                      TableHeaderCellWidget('المده'),
                      TableHeaderCellWidget('السعر'),
                      TableHeaderCellWidget('المشتركين'),
                      TableHeaderCellWidget('الحاله'),
                    ]),

                    TableHelper.buildDataRow(
                      cells: [
                        TableCellWidget('شهر واحد'),
                        TableCellWidget('30 يوم'),
                        TableCellWidget('500 EGP'),
                        TableCellWidget('35'),
                        TableCellWidget(
                          'نشط',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButtonWidget(text: 'اضافه اشتراك'),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
