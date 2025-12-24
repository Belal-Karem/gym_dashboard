import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/report/data/models/model/attendance_report_mode.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_attendance_cubit.dart';

class CustomPresence extends StatelessWidget {
  const CustomPresence({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyAttendanceCubit, DailyAttendanceState>(
      builder: (context, state) {
        if (state is DailyAttendanceLoading) {
          return const CircularProgressIndicator();
        }
        if (state is DailyAttendanceLoaded) {
          final a = state.attendance;
          return CustomPresenceUi(a: a);
        }
        if (state is DailyAttendanceError) {
          return Text(state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class CustomPresenceUi extends StatelessWidget {
  const CustomPresenceUi({super.key, required this.a});

  final List<AttendanceReportModel> a;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('حضور', style: AppStyle.style20W500),
          SizedBox(height: 10),
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
                      TableHeaderCellWidget('الاسم'),
                      TableHeaderCellWidget('بداية'),
                      TableHeaderCellWidget('النهايه'),
                      TableHeaderCellWidget('الحاله'),
                      TableHeaderCellWidget('التوقيت'),
                      TableHeaderCellWidget('ملحظه'),
                    ]),

                    ...a.map(
                      (a) => TableHelper.buildDataRow(
                        cells: [
                          TableCellWidget('${a.memberName}'),
                          TableCellWidget('${a.startDate}'),
                          TableCellWidget('${a.endDate}'),
                          TableCellWidget('${a.status}'),
                          TableCellWidget('${a.attendanceTime}'),
                          TableCellWidget('${a.note}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
