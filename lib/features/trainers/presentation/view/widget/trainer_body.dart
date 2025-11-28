import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/top_section_of_trainer.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/view_client.dart';

class TrainerBody extends StatelessWidget {
  const TrainerBody({super.key});

  final bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المدربين',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          TopSectionOfTrainer(),
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
                        TableCellWidget(
                          isActive ? 'نشط' : 'غير نشط',
                          style: isActive
                              ? TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                )
                              : TextStyle(color: Colors.red),
                        ),
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
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButtonWidget(text: 'اضافه مدرب', onPressed: () {}),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
