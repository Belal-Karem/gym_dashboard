import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/report/data/models/repo/daily_attendance_repo_impl.dart';
import 'package:power_gym/features/report/data/models/repo/daily_report_comment_repo_impl.dart';
import 'package:power_gym/features/report/data/models/repo/daily_summary_repo_impl.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_attendance_cubit.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_report_comment_cubit.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_summary_cubit.dart';
import 'package:power_gym/features/report/presentation/view/widget/repo_view_body.dart';

class RepoView extends StatelessWidget {
  const RepoView({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final dateId = _toDateId(selectedDate);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DailySummaryCubit(
            DailySummaryRepoImpl(FirebaseFirestore.instance),
          )..load(dateId),
        ),
        BlocProvider(
          create: (_) => DailyAttendanceCubit(
            DailyAttendanceRepoImpl(FirebaseFirestore.instance),
          )..load(dateId),
        ),
        BlocProvider(
          create: (_) => DailyReportCommentCubit(
            DailyReportCommentRepoImpl(FirebaseFirestore.instance),
          ),
        ),
      ],
      child: Scaffold(body: RepoViewBody(selectedDate: selectedDate)),
    );
  }

  String _toDateId(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}
