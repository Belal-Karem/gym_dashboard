import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/members/presentation/view/widget/dialog_add_member.dart';
import 'package:power_gym/features/members/presentation/view/widget/top_section_of_members.dart';

class MemberBody extends StatelessWidget {
  const MemberBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('أعضاء', style: AppStyle.stylebold26),
          TopSectionOfMembers(),
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
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1.2),
                  },
                  children: [
                    TableHelper.buildHeaderRow([
                      TableHeaderCellWidget('id'),
                      TableHeaderCellWidget('الاسم'),
                      TableHeaderCellWidget('الشتراك'),
                      TableHeaderCellWidget('تاريخ البدء'),
                      TableHeaderCellWidget('تاريخ الانتهاء'),
                      TableHeaderCellWidget('الحاله'),
                    ]),

                    TableHelper.buildDataRow(
                      cells: [
                        TableCellWidget('5'),
                        TableCellWidget('Belal'),
                        TableCellWidget('3 أشهر'),
                        TableCellWidget('01/01/2023'),
                        TableCellWidget('01/03/2023'),
                        TableCellWidget(
                          'نشط',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButtonWidget(
            text: 'إضافة عضو',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(child: DialogAddMember());
                },
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
