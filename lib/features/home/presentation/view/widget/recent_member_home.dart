import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/home/data/models/model/dash_board_model.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/today_attendance_cubit/today_attendance_cubit.dart';

class RecentMemberHome extends StatelessWidget {
  const RecentMemberHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayAttendanceCubit, TodayAttendanceState>(
      builder: (context, state) {
        if (state is TodayAttendanceLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodayAttendanceLoaded) {
          final memberIds = state.memberIds;
          return RecentMemberHomeUi(memberIds: memberIds);
        } else if (state is TodayAttendanceError) {
          return CustomErrorWidget(errMessage: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class RecentMemberHomeUi extends StatelessWidget {
  const RecentMemberHomeUi({super.key, required this.memberIds});
  final List<String> memberIds;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      padding: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              'معلومات الأعضاء',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // لو الجدول كبير
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
                3: FlexColumnWidth(1.2),
              },
              children: [
                // Header
                TableHelper.buildHeaderRow([
                  TableHeaderCellWidget('id'),
                  TableHeaderCellWidget('الاسم'),
                  TableHeaderCellWidget('اليوم'),
                  TableHeaderCellWidget('الحالة'),
                ]),

                // بيانات الأعضاء
                ...memberIds.map((member) {
                  return TableHelper.buildDataRow(
                    cells: [
                      TableCellWidget(member),
                      TableCellWidget(member),
                      TableCellWidget(member.toString()), // لو عايز تعرض اليوم
                      TableCellWidget(
                        member,
                        style: TextStyle(
                          color: member.toLowerCase() == 'active'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
