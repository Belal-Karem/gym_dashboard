import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/home/presentation/view/widget/show_dialog_data_Member_info.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/view/widget/member_update_dialog.dart';

class MembersDataTable extends StatelessWidget {
  const MembersDataTable({
    super.key,
    required this.members,
    required this.subscriptions,
  });

  final List<MemberModel> members;
  final Map<String, MemberSubscriptionModel> subscriptions;

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
              final sub = subscriptions[member.id];

              if (sub == null) {
                return TableHelper.buildDataRow(
                  onTap: (_) {},
                  cells: [
                    TableCellWidget(member.memberId),
                    TableCellWidget(member.name),
                    TableCellWidget(member.phone),
                    TableCellWidget('-'), // startDate
                    TableCellWidget('-'), // endDate
                    TableCellWidget('-'), // remainingDays
                    TableCellWidget('-'), // attendance
                    TableCellWidget(
                      'No subscription',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                );
              }

              // لو الاشتراك موجود
              return TableHelper.buildDataRow(
                onTap: (cells) {
                  showDialog(
                    context: context,
                    builder: (_) => MemberDialog(member: member),
                  );
                },
                cells: [
                  TableCellWidget(member.memberId),
                  TableCellWidget(member.name),
                  TableCellWidget(member.phone),
                  TableCellWidget(
                    DateFormat('yyyy-MM-dd', 'en_US').format(sub.startDate),
                  ),
                  TableCellWidget(
                    DateFormat('yyyy-MM-dd', 'en_US').format(sub.endDate),
                  ),
                  TableCellWidget(sub.remainingDays.toString()),
                  TableCellWidget(sub.attendance.toString()),
                  TableCellWidget(
                    sub.status.name,
                    style: sub.status == SubscriptionStatus.active
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
              );
            }),
          ],
        ),
      ),
    );
  }
}
