import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/home/data/models/model/recent_member_model.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/recent_member_cubit.dart';

class RecentMemberHome extends StatelessWidget {
  const RecentMemberHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentMemberCubit, RecentMemberState>(
      builder: (context, state) {
        if (state is RecentMemberLoading) {
          return const CircularProgressIndicator();
        }

        if (state is RecentMemberLoaded) {
          print('==================${state.members}');
          return RecentMemberHomeUi(members: state.members);
        }

        if (state is RecentMemberError) {
          print('==================${state.message}');
          return Text(state.message);
        }

        return const SizedBox();
      },
    );
  }
}

class RecentMemberHomeUi extends StatelessWidget {
  const RecentMemberHomeUi({super.key, required this.members});

  final List<RecentMemberModel> members;

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
                TableHelper.buildHeaderRow([
                  TableHeaderCellWidget('id'),
                  TableHeaderCellWidget('الاسم'),
                  TableHeaderCellWidget('الايام'),
                  TableHeaderCellWidget('الحاله'),
                ]),

                ...members.map(
                  (members) => TableHelper.buildDataRow(
                    cells: [
                      TableCellWidget(
                        members.memberId.isEmpty ? '---' : members.memberId,
                      ),
                      TableCellWidget(
                        members.name.isEmpty ? '---' : members.name,
                      ),
                      TableCellWidget(
                        members.attendanceCount.toString().isEmpty
                            ? '---'
                            : members.attendanceCount.toString(),
                      ),
                      TableCellWidget(
                        members.status.isEmpty ? '---' : members.status,
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
        ],
      ),
    );
  }
}
