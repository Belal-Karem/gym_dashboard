import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/members/presentation/view/widget/members_data_table.dart';

class MembersData extends StatelessWidget {
  const MembersData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembersCubit, MembersState>(
      builder: (context, state) {
        if (state is MembersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MembersLoaded) {
          final members = state.members;
          return MembersDataTable(members: members);
        } else if (state is MembersError) {
          return CustomErrorWidget(errMessage: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
