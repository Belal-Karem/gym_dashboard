import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit.dart';
import 'package:power_gym/features/home/presentation/view/widget/elevated_boutton_member_info.dart';
import 'package:power_gym/features/home/presentation/view/widget/text_boutton_member_info.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class SubscriptionActions extends StatelessWidget {
  const SubscriptionActions({required this.member});

  final MemberModel member;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MemberSubscriptionCubit, MemberSubscriptionState>(
      listenWhen: (_, curr) => curr is MemberSubscriptionAttendanceSuccess,
      listener: (context, state) {
        final s = state as MemberSubscriptionAttendanceSuccess;
        context.read<AttendanceCubit>().markPresent(
          subscription: s.subscription,
          plan: s.plan,
          member: member,
        );
      },
      builder: (context, state) {
        final cubit = context.read<MemberSubscriptionCubit>();
        final subscription = cubit.cachedSubscriptions[member.id];

        if (subscription == null) {
          return const Text(
            'لا يوجد اشتراك نشط',
            style: TextStyle(color: Colors.red),
          );
        }

        final plan = cubit.getPlan(subscription.subscriptionId);
        if (plan == null) {
          return const CircularProgressIndicator(strokeWidth: 2);
        }

        final remainingInvites =
            subscription.totalInvitations - subscription.usedInvitations;

        final canAttend =
            subscription.status == SubscriptionStatus.active &&
            subscription.attendance < plan.maxAttendance;

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            ElevatedBouttonMemberInfo(
              text: 'تسجيل حضور',
              onPressed: canAttend
                  ? () => cubit.markAttendance(subscription: subscription)
                  : null,
            ),

            TextBouttonMemberInfo(
              text: 'تجميد',
              onPressed:
                  subscription.freeze > 0 &&
                      subscription.status == SubscriptionStatus.active
                  ? () => _handleFreeze(context, subscription, plan)
                  : null,
            ),

            TextBouttonMemberInfo(
              text: 'دعوة مرافق ($remainingInvites)',
              onPressed: remainingInvites > 0
                  ? () => _handleInvitation(context, subscription)
                  : null,
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleFreeze(
    BuildContext context,
    MemberSubscriptionModel subscription,
    SubModel plan,
  ) async {}

  Future<void> _handleInvitation(
    BuildContext context,
    MemberSubscriptionModel subscription,
  ) async {
    // نفس منطق الدعوة
  }
}
