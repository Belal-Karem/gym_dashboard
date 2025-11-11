import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/payment/presentation/view/widget/top_section_of_payment.dart';

class PaymentBody extends StatelessWidget {
  const PaymentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('المدفوعات', style: AppStyle.stylebold26),
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
                    4: FlexColumnWidth(1.2),
                  },
                  children: [
                    TableHelper.buildHeaderRow([
                      TableHeaderCellWidget('الاسم'),
                      TableHeaderCellWidget('الخطه'),
                      TableHeaderCellWidget('الحاله'),
                      TableHeaderCellWidget('التاريخ'),
                      TableHeaderCellWidget('طريق الدفع'),
                    ]),

                    TableHelper.buildDataRow(
                      cells: [
                        TableCellWidget('Ali'),
                        TableCellWidget('monthly'),
                        TableCellWidget('500'),
                        TableCellWidget('01/03/2023'),
                        TableCellWidget(
                          'cash',
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
          ElevatedButtonWidget(text: 'اضافة مصاريف'),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
