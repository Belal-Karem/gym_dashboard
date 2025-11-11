import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';

class CustomPresence extends StatelessWidget {
  const CustomPresence({super.key});

  final bool noteActive = true;
  final bool statuActive = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('حضور', style: AppStyle.style20W500),
          SizedBox(height: 10),
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
                      TableHeaderCellWidget('بداية'),
                      TableHeaderCellWidget('النهايه'),
                      TableHeaderCellWidget('الحاله'),
                      TableHeaderCellWidget('التوقيت'),
                      TableHeaderCellWidget('ملحظه'),
                    ]),

                    TableHelper.buildDataRow(
                      cells: [
                        TableCellWidget('Ali'),
                        TableCellWidget('01/03/2023'),
                        TableCellWidget('01/03/2024'),
                        TableCellWidget(statuActive ? 'P+: احمد' : '_'),
                        TableCellWidget('6.30Pm'),
                        TableCellWidget(
                          noteActive ? 'عليه 50' : '_',
                          style: noteActive
                              ? TextStyle(color: Colors.red)
                              : TextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
