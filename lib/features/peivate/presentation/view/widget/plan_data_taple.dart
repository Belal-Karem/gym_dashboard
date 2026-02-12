import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/helper/format_date_helper.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/peivate/data/models/private_model/private_model.dart';
import 'package:power_gym/features/peivate/presentation/view/widget/private_update_dialog.dart';

class PrivateDataTaple extends StatelessWidget {
  const PrivateDataTaple({super.key, required this.private});

  final List<PrivateModel> private;

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
            6: FlexColumnWidth(1.2),
          },
          children: [
            TableHelper.buildHeaderRow([
              TableHeaderCellWidget('الاسم'),
              TableHeaderCellWidget('المدرب'),
              TableHeaderCellWidget('السعر'),
              TableHeaderCellWidget('تاريخ النتهاء'),
              TableHeaderCellWidget('الجلسات'),
              TableHeaderCellWidget('الحضور'),
              TableHeaderCellWidget('الحاله'),
            ]),
            ...private.map(
              (private) => TableHelper.buildDataRow(
                onTap: (cells) {
                  showDialog(
                    context: context,
                    builder: (_) => PrivateUpdateDialog(privateModel: private),
                  );
                },
                cells: [
                  TableCellWidget(private.member.name),
                  TableCellWidget(private.trainer.name),
                  TableCellWidget(private.paid.toString()),
                  TableCellWidget(
                    FormatDateHelper.formatDate(private.endDate.toString()),
                  ),
                  TableCellWidget(private.totalSessions.toString()),
                  TableCellWidget(private.usedSessions.toString()),
                  TableCellWidget(
                    private.status.arabicNameForPrivate,
                    style: private.status == PrivateStatus.active
                        ? const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          )
                        : const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
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
