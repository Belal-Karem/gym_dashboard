import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/members_statistics_card.dart';
import 'package:power_gym/features/members/data/models/member_model/members_count_mode.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_cubit.dart';

class MembersStatisticsRow extends StatelessWidget {
  const MembersStatisticsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembersCountStatsCubit, MembersStatsState>(
      builder: (context, state) {
        if (state is MembersStatsLoading) {
          return CircularProgressIndicator();
        } else if (state is MembersStatsLoaded) {
          final count = state.count;
          return MembersStatisticsRowData(count: count);
        } else if (state is MembersStatsError) {
          return Text('خطأ: ${state.message}');
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class MembersStatisticsRowData extends StatelessWidget {
  const MembersStatisticsRowData({super.key, required this.count});

  final MembersCountMode count;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: MembersStatisticsCard(number: count.men, text: 'الرجال'),
          ),
          Expanded(
            child: MembersStatisticsCard(number: count.women, text: 'النساء'),
          ),
          Expanded(
            child: MembersStatisticsCard(number: count.children, text: 'اطفال'),
          ),
          Expanded(
            child: MembersStatisticsCard(number: count.active, text: 'النشط'),
          ),
          Expanded(
            child: MembersStatisticsCard(
              number: count.expired,
              text: 'منتهي',
              textStyle: TextStyle(fontSize: 15, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
