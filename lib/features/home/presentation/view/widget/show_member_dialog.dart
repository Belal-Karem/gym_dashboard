import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/home/presentation/view/widget/show_dialog_data_Member_info.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

import '../../../../member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';

class ShowMemberDialog extends StatelessWidget {
  const ShowMemberDialog({super.key, required this.member});

  final MemberModel member;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<MemberSubscriptionCubit>(),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: BlocBuilder<MemberSubscriptionCubit, MemberSubscriptionState>(
          builder: (context, state) {
            final cubit = context.watch<MemberSubscriptionCubit>();
            final subscription = cubit.cachedSubscriptions[member.id];

            if (subscription == null) {
              return const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return ShowDialogDataMemberInfo(
              member: member,
              subscription: subscription,
            );
          },
        ),
      ),
    );
  }
}
