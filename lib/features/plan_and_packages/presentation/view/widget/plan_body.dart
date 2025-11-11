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
            'Payment',
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
                    3: FlexColumnWidth(1.2),
                  },
                  children: [
                    TableHelper.buildHeaderRow([
                      TableHeaderCellWidget('Nema'),
                      TableHeaderCellWidget('price'),
                      TableHeaderCellWidget('Duration'),
                      TableHeaderCellWidget('sessions'),
                    ]),

                    TableHelper.buildDataRow(
                      cells: [
                        TableCellWidget('Ali'),
                        TableCellWidget('30'),
                        TableCellWidget('month'),
                        TableCellWidget('8'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButtonWidget(text: 'Add Payment'),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
