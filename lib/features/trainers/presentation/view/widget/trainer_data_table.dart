import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/trainer_update_dialog.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/view_client.dart';

class TrainerDataTable extends StatelessWidget {
  const TrainerDataTable({super.key, required this.trainer});
  final List<TrainerModel> trainer;

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

            ...trainer.map(
              (trainer) => TableHelper.buildDataRow(
                onTap: (cells) {
                  showDialog(
                    context: context,
                    builder: (_) => TrainerUpdateDialog(trainer: trainer),
                  );
                },
                cells: [
                  TableCellWidget(trainer.name),
                  TableCellWidget(trainer.phone),
                  TableCellWidget(
                    trainer.status,
                    style: trainer.status == 'نشط'
                        ? TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          )
                        : TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TableCellWidget(trainer.ptNumber),
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
            ),
          ],
        ),
      ),
    );
  }
}
