import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_summary_cubit.dart';
import 'package:power_gym/features/report/presentation/view/widget/daily_summary.dart';

class DailySummaryData extends StatelessWidget {
  const DailySummaryData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailySummaryCubit, DailySummaryState>(
      builder: (context, state) {
        if (state is DailySummaryLoading) {
          return const CircularProgressIndicator();
        }
        if (state is DailySummaryLoaded) {
          final s = state.summary;
          return DailySummary(s: s);
        }
        if (state is DailySummaryError) {
          return Text(state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
