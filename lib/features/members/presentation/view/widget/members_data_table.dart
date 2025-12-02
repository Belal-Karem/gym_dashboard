import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/view/widget/member_update_dialog.dart';

class MembersDataTable extends StatelessWidget {
  const MembersDataTable({super.key, required this.members});

  final List<MemberModel> members;

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
            TableHelper.buildHeaderRow(const [
              TableHeaderCellWidget('id'),
              TableHeaderCellWidget('الاسم'),
              TableHeaderCellWidget('الشتراك'),
              TableHeaderCellWidget('تاريخ البدء'),
              TableHeaderCellWidget('تاريخ الانتهاء'),
              TableHeaderCellWidget('الحضور'),
              TableHeaderCellWidget('الغياب'),
              TableHeaderCellWidget('الحاله'),
            ]),
            ...members.map(
              (member) => TableHelper.buildDataRow(
                onTap: (cells) {
                  showDialog(
                    context: context,
                    builder: (_) => MemberDialog(member: member),
                  );
                },

                cells: [
                  TableCellWidget(member.memberid),
                  TableCellWidget(member.name),
                  TableCellWidget(member.phone),
                  TableCellWidget(member.startdata),
                  TableCellWidget(member.enddata),
                  TableCellWidget(member.attendance),
                  TableCellWidget(member.absence),
                  TableCellWidget(
                    'نشط',
                    style: const TextStyle(
                      color: Colors.green,
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
    ;
  }
}
