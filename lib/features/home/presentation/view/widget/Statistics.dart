import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/service_locator.dart';
import 'package:power_gym/core/widget/app_loading_widget.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/dashboard_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_state_state.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_stats_cubit.dart';

import '../../../../../core/utils/app_style.dart';
import 'statistics_container.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTodayAttendanceCubit, GetTodayAttendanceState>(
      builder: (context, state) {
        if (state is GetTodayAttendanceLoading) {
          return AppLoadingWidget();
        } else if (state is GetTodayAttendanceLoaded) {
          return StatisticsUi(count: state.todayAttendanceCount);
        } else if (state is GetTodayAttendanceError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('Unknown state'));
        }
      },
    );
  }
}

class StatisticsUi extends StatelessWidget {
  const StatisticsUi({super.key, required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomContainerStatistics(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<MembersCountStatsCubit, MembersCountStatsState>(
                  builder: (context, state) {
                    if (state is MembersCountStatsLoaded) {
                      return Text(
                        state.count.active.toString(),
                        style: AppStyle.style30w500,
                      );
                    } else {
                      return const Text('0', style: TextStyle(fontSize: 30));
                    }
                  },
                ),
                const Text('أعضاء', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),

        Expanded(
          child: StatisticsContainer(
            title: count.toString(),
            subTitle: 'الحالي',
          ),
        ),
      ],
    );
  }
}
