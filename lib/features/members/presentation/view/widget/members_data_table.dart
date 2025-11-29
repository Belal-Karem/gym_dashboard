import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

class MembersDataTable extends StatelessWidget {
  MembersDataTable({super.key});

  CollectionReference member = FirebaseFirestore.instance.collection(
    kMemberCollections,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: member.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('لا توجد بيانات');
        }
        if (snapshot.hasData) {
          List<MemberModel> memberlist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            memberlist.add(
              MemberModel.fromjson(
                snapshot.data!.docs[i].data() as Map<String, dynamic>,
              ),
            );
          }
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

                  for (var m in memberlist)
                    TableHelper.buildDataRow(
                      cells: [
                        TableCellWidget(m.id.toString()),
                        TableCellWidget(m.name),
                        TableCellWidget(m.phone),
                        TableCellWidget(m.startdata),
                        TableCellWidget(m.enddata),
                        TableCellWidget(m.attendance),
                        TableCellWidget(m.absence),
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
          );
        } else {
          return Text('eror');
        }
      },
    );
  }
}


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