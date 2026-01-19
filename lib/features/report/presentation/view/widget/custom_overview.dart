import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_attendance_cubit.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_report_comment_cubit.dart';
import 'package:power_gym/features/report/presentation/view/widget/expandable_note.dart';
import 'package:power_gym/features/report/presentation/view/widget/list_title_item.dart';
import 'package:power_gym/model/list_title_overview_model.dart';

class CustomOverview extends StatelessWidget {
  const CustomOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ملخص', style: AppStyle.style20W500),
        SizedBox(height: 10),

        BlocBuilder<DailyAttendanceCubit, DailyAttendanceState>(
          builder: (context, state) {
            if (state is DailyAttendanceLoaded) {
              final a = state.attendance;
              return ListTitleItem(
                listTitleOverviewModel: ListTitleOverviewModel(
                  text: 'إجمالي الزيارات',
                  data: a.length.toString(),
                  icon: Icons.person,
                ),
              );
            }
            if (state is DailyAttendanceError) {
              return Text(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
        BlocBuilder<DailyReportCommentCubit, DailyReportCommentState>(
          builder: (context, state) {
            if (state is DailyReportCommentStateLoading) {
              return const CircularProgressIndicator();
            }
            if (state is DailyReportCommentStateLoaded) {
              return CommentSesstion(data: state.comment?.comment ?? '_');
            }
            if (state is DailyReportCommentStateError) {
              return Text('Error: ${state.message}');
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

class CommentSesstion extends StatelessWidget {
  const CommentSesstion({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: ListTile(
        titleTextStyle: const TextStyle(fontSize: 20),
        leadingAndTrailingTextStyle: const TextStyle(fontSize: 18),
        title: const Text('ملحوظة'),
        leading: const Icon(Icons.comment),
        trailing: SizedBox(
          width: 180, // مهم عشان الـ ellipsis يشتغل
          child: ExpandableNote(text: data),
        ),
      ),
    );
  }
}
