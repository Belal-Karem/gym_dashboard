import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';
import 'package:power_gym/features/subscriptions/presentation/view/widget/subscriptions_update_dialog.dart';

class SubscriptionsDataTaple extends StatelessWidget {
  const SubscriptionsDataTaple({super.key, required this.subs});

  final List<SubModel> subs;

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
            4: FlexColumnWidth(1.2),
          },
          children: [
            TableHelper.buildHeaderRow([
              TableHeaderCellWidget('اسم الخطه'),
              TableHeaderCellWidget('المده'),
              TableHeaderCellWidget('السعر'),
              TableHeaderCellWidget('المشتركين'),
              TableHeaderCellWidget('الحاله'),
            ]),
            ...subs.map(
              (subs) => TableHelper.buildDataRow(
                onTap: (cells) {
                  showDialog(
                    context: context,
                    builder: (_) => SubscriptionsUpdateDialog(subModel: subs),
                  );
                },
                cells: [
                  TableCellWidget(subs.type),
                  TableCellWidget(subs.duration.toString()),
                  TableCellWidget(subs.price),
                  TableCellWidget('35'),
                  TableCellWidget(
                    subs.status,
                    style: subs.status == 'نشط'
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
            ),
          ],
        ),
      ),
    );
  }
}
