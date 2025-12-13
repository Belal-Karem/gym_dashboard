import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/plan_and_packages/data/models/plan_model/plan_model.dart';

class PlanDataTaple extends StatelessWidget {
  const PlanDataTaple({super.key, required this.plan});

  final List<PlanModel> plan;

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
            5: FlexColumnWidth(1.2),
          },
          children: [
            TableHelper.buildHeaderRow([
              TableHeaderCellWidget('الاسم'),
              TableHeaderCellWidget('المدرب'),
              TableHeaderCellWidget('السعر'),
              TableHeaderCellWidget('المده'),
              TableHeaderCellWidget('الجلسات'),
              TableHeaderCellWidget('الحضور'),
            ]),
            ...plan.map(
              (plan) => TableHelper.buildDataRow(
                cells: [
                  TableCellWidget(plan.memberid),
                  TableCellWidget(plan.trainerid.name),
                  TableCellWidget(plan.price),
                  TableCellWidget('month'),
                  TableCellWidget(plan.session),
                  TableCellWidget(plan.attendance),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
