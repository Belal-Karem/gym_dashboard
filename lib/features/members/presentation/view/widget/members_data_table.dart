import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_state.dart';
import 'package:power_gym/features/members/presentation/view/widget/member_update_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembersDataTable extends StatelessWidget {
  const MembersDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembersCubit, MembersState>(
      builder: (context, state) {
        if (state is MembersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MembersLoaded) {
          final members = state.members;
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
                  TableHelper.buildHeaderRow([
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
        } else if (state is MembersError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void showRowDialog({
    required BuildContext context,
    required List<Widget> cells,
    required VoidCallback onDelete,
    required VoidCallback onUpdate,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("بيانات العضو"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: cells
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: cell,
                  ),
                )
                .toList(),
          ),

          actions: [
            TextButton(
              onPressed: onDelete,
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: onUpdate,
              child: const Text("Update", style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}


//  onTap: (cells) {
//                 final memberData = {
//                   'name': 'بلال',
//                   'age': 25,
//                   'phone': '0123456789',
//                   'status': 'نشط',
//                 };

//                 final memberId =
//                     'id123'; // ضع هنا الـ doc id الخاص بالعضو من Firebase

//                 showDialog(
//                   context: context,
//                   builder: (_) => MemberUpdateDialog(
//                     memberId: memberId,
//                     memberData: memberData,
//                   ),
//                 );
//               },

// for (var m in memberlist)
// StreamBuilder(
//       stream: member.snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasError) {
//           return Text("Firestore Error: ${snapshot.error}");
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Text("لا توجد بيانات");
//         }
//         if (snapshot.hasData) {
//           List<MemberModel> memberlist = [];
//           for (int i = 0; i < snapshot.data!.docs.length; i++) {
//             memberlist.add(
//               MemberModel.fromjson(
//                 snapshot.data!.docs[i].data() as Map<String, dynamic>,
//               ),
//             );
//           }

// TableHelper.buildDataRow(
                //   cells: [
                //     TableCellWidget('5'),
                //     TableCellWidget('Belal'),
                //     TableCellWidget('3 أشهر'),
                //     TableCellWidget('01/01/2023'),
                //     TableCellWidget('01/03/2023'),
                //     TableCellWidget('30'),
                //     TableCellWidget('60'),
                // TableCellWidget(
                //   'نشط',
                //   style: const TextStyle(
                //     color: Colors.green,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                //   ],
                // ),
                // ],