import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/members/presentation/view/widget/members_data_table.dart';

class MembersData extends StatelessWidget {
  const MembersData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MembersCubit, MembersState>(
      listener: (context, state) {
        if (state is MembersLoaded) {
          context
              .read<MemberSubscriptionCubit>()
              .loadMembersActiveSubscriptions(state.members);
        }
      },
      child: BlocBuilder<MembersCubit, MembersState>(
        builder: (context, state) {
          print('SizedBox2');
          if (state is MembersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MembersLoaded) {
            return BlocBuilder<
              MemberSubscriptionCubit,
              MemberSubscriptionState
            >(
              builder: (context, subState) {
                final subscriptions = context
                    .read<MemberSubscriptionCubit>()
                    .cachedSubscriptions;

                if (subscriptions.isEmpty) {
                  return const Center(child: Text('لا توجد اشتراكات'));
                }

                return MembersDataTable(
                  members: state.members,
                  subscriptions: subscriptions,
                );
              },
            );
          }

          if (state is MembersError) {
            return CustomErrorWidget(errMessage: state.message);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
