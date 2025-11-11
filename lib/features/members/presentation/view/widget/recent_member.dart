import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';

class RecentMember extends StatelessWidget {
  const RecentMember({super.key});

  final bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      padding: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              'معلومات الأعضاء',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SingleChildScrollView(
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
                  TableHeaderCellWidget('id'),
                  TableHeaderCellWidget('الاسم'),
                  TableHeaderCellWidget('الايام'),
                  TableHeaderCellWidget('الحاله'),
                ]),

                TableHelper.buildDataRow(
                  cells: [
                    TableCellWidget('20'),
                    TableCellWidget('belal karem'),
                    TableCellWidget('25'),
                    TableCellWidget(
                      isActive ? 'نشط' : 'غير نشط',
                      style: isActive
                          ? TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            )
                          : TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
