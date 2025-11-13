import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/payment/presentation/view/widget/top_section_of_payment.dart';

class PlanBody extends StatelessWidget {
  const PlanBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الاشتراكات الخاصة',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          TopSectionOfPayment(),
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
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1.2),
                  },
                  children: [
                    TableHelper.buildHeaderRow([
                      TableHeaderCellWidget('الاسم'),
                      TableHeaderCellWidget('المدرب'),
                      TableHeaderCellWidget('السعر'),
                      TableHeaderCellWidget('المده'),
                      TableHeaderCellWidget('الجلسات'),
                      TableHeaderCellWidget('الحضور'),
                    ]),

                    TableHelper.buildDataRow(
                      cells: [
                        TableCellWidget('Ali'),
                        TableCellWidget('Ahmed'),
                        TableCellWidget('800'),
                        TableCellWidget('month'),
                        TableCellWidget('8'),
                        TableCellWidget('4'),
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
