import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/date_helper.dart';
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
            7: FlexColumnWidth(1),
            8: FlexColumnWidth(1.2),
          },
          children: [
            TableHelper.buildHeaderRow(const [
              TableHeaderCellWidget('id'),
              TableHeaderCellWidget('الاسم'),
              TableHeaderCellWidget('الهاتف'),
              TableHeaderCellWidget('تاريخ البدء'),
              TableHeaderCellWidget('تاريخ الانتهاء'),
              TableHeaderCellWidget('الأيام المتبقية'),
              TableHeaderCellWidget('الحضور'),
              TableHeaderCellWidget('الحالة'),
            ]),
            ...members.map((member) {
              final sub = member.subscription;
              final endDate = sub?.endDate; // DateTime?
              final remainingDays = sub?.remainingDays ?? 0;

              return TableHelper.buildDataRow(
                onTap: (cells) {
                  showDialog(
                    context: context,
                    builder: (_) => MemberUpdateDialog(member: member),
                  );
                },
                cells: [
                  TableCellWidget(member.memberId),
                  TableCellWidget(member.name),
                  TableCellWidget(member.phone),
                  TableCellWidget(
                    DateHelper.formatPaymentDate(member.startDate),
                  ),
                  TableCellWidget(
                    endDate != null
                        ? DateHelper.formatPaymentDate(endDate)
                        : '-',
                  ),
                  TableCellWidget('$remainingDays'),
                  TableCellWidget(member.attendance.toString()),
                  TableCellWidget(
                    (sub?.isExpired ?? false) ? 'منتهي' : member.status,
                    style: (sub?.isExpired ?? false)
                        ? const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          )
                        : const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
