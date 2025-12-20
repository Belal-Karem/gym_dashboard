import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/service_locator.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/dashboard_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_state_state.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_stats_cubit.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DashboardLoaded) {
          return BlocProvider(
            create: (context) => sl<MembersCountStatsCubit>(),
            child: StatisticsUi(count: state.todayAttendanceCount),
          );
        } else if (state is DashboardError) {
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
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }
                    return const Text('0', style: TextStyle(fontSize: 30));
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

class StatisticsContainer extends StatelessWidget {
  const StatisticsContainer({
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
          // Text('منتهية', style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
