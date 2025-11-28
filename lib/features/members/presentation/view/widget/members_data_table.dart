import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';

class MembersDataTable extends StatelessWidget {
  const MembersDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
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
            5: FlexColumnWidth(1),
            6: FlexColumnWidth(1),
            7: FlexColumnWidth(1.2),
          },
          children: [
            TableHelper.buildHeaderRow([
              TableHeaderCellWidget('id'),
              TableHeaderCellWidget('الاسم'),
              TableHeaderCellWidget('الشتراك'),
              TableHeaderCellWidget('تاريخ البدء'),
              TableHeaderCellWidget('تاريخ الانتهاء'),
              TableHeaderCellWidget('الحضور'),
              TableHeaderCellWidget('الغياب'),
              TableHeaderCellWidget('الحاله'),
            ]),

            TableHelper.buildDataRow(
              cells: [
                TableCellWidget('5'),
                TableCellWidget('Belal'),
                TableCellWidget('3 أشهر'),
                TableCellWidget('01/01/2023'),
                TableCellWidget('01/03/2023'),
                TableCellWidget('30'),
                TableCellWidget('60'),
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
    );
  }
}
