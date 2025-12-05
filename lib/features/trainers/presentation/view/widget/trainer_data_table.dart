import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/view_client.dart';

class TrainerDataTable extends StatelessWidget {
  const TrainerDataTable({super.key});

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
            // 3: FlexColumnWidth(1),
            4: FlexColumnWidth(1.2),
          },
          children: [
            TableHelper.buildHeaderRow([
              TableHeaderCellWidget('الاسم'),
              TableHeaderCellWidget('الهاتف'),
              // TableHeaderCellWidget('Price'),
              TableHeaderCellWidget('الحاله'),
              TableHeaderCellWidget('Pt'),
            ]),

            TableHelper.buildDataRow(
              cells: [
                TableCellWidget('Belal'),
                TableCellWidget('01126062449'),
                // TableCellWidget('500 EGP'),
                TableCellWidget('نشط'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TableCellWidget('35'),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child:
                                    ViewClient(), // هنا بيظهر الـ Widget فعلاً
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff17181D),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('مشاهده'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
