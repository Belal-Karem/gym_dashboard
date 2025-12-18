import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/members_count_for_dashboard_cubit/members_count_for_dashboard_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/members_count_for_dashboard_cubit/members_count_for_dashboard_state.dart';
import 'package:power_gym/features/members/data/models/member_model/members_count_mode.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      MembersCountForDashboardCubit,
      MembersCountForDashboardState
    >(
      builder: (context, state) {
        if (state is MembersCountForDashboardLoading) {
          return CircularProgressIndicator();
        } else if (state is MembersCountForDashboardLoaded) {
          final count = state.count;
          return StatisticsUi(membercount: count);
        } else if (state is MembersCountForDashboardError) {
          return Text('خطأ: ${state.message}');
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class StatisticsUi extends StatelessWidget {
  const StatisticsUi({super.key, required this.membercount});

  final MembersCountMode membercount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomStatistics(
            title: membercount.total.toString(),
            subTitle: 'الاعضاء',
          ),
        ),
        Expanded(
          child: CustomContainerStatistics(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '5',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Text('الحالي', style: TextStyle(fontSize: 15)),
                // Text('منتهية', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomStatistics extends StatelessWidget {
  const CustomStatistics({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          Text(subTitle, style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
